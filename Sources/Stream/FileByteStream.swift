// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

public final class FileByteStream: ByteStream, RandomAccessStream {
    let bytes: UnsafeMutablePointer<UInt8>
    let count: Int
    var current: UnsafeMutablePointer<UInt8>
    var index: Int = 0

    public init(path: String) {
        let (content, size) = FileByteStream.open(path: path)
        bytes = content ?? UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        count = content == nil ? 0 : size
        current = bytes
    }

    deinit {
        bytes.deallocate()
    }

    public override var available: Bool {
        return index > -1 && index < count
    }

    public override func peek() -> UInt8 {
        return available ? current.pointee : 0
    }

    public override func peek(offset: Int) -> UInt8 {
        return peek(offset: offset, seek: .current)
    }

    public func peek(offset: Int, seek: SeekOffset) -> UInt8 {
        let next: Int
        switch seek {
        case .current:
            next = index + offset
        case .start:
            next = offset
        case .end:
            next = count + offset
        }
        if next > -1 && next < count {
            return current.advanced(by: offset).pointee
        } else {
            return 0
        }
    }
    
    public func peek(size: Int) -> Data {
        var data = Data()
        if index + size < count {
            data.append(current, count: size)
        }
        return data
    }

    // bool peek(Value* pointer);
    func peek(into pointer: UnsafeMutablePointer<UInt8>) -> Bool {
        pointer.initialize(to: current.pointee)
        return available
    }

    // size_t peek(Value* pointer size_t size);
    func peek(into pointer: UnsafeMutablePointer<UInt8>, size: Int) -> Bool {
        let next: Int = index + size
        if next > -1 && next <= count {
            pointer.initialize(from: current, count: size)
            return true
        } else {
            return false
        }
    }
    
    func peekRaw(size: Int) -> UnsafePointer<UInt8>? {
        let next: Int = index + size
        if next > -1 && next <= count {
            return UnsafePointer<UInt8>(current)
        } else {
            return nil
        }
    }

    @discardableResult
    public override func move() -> Bool {
        index += 1
        if available {
            current = current.advanced(by: 1)
        }
        return available
    }

    @discardableResult
    public override func move(offset: Int) -> Bool {
        return move(offset: offset, seek: .current)
    }

    @discardableResult
    public func move(offset: Int, seek: SeekOffset) -> Bool {
        switch seek {
        case .current:
            index += offset
        case .start:
            index = offset
        case .end:
            index = count + offset
        }
        if available {
            current = bytes.advanced(by: index)
        }
        return available
    }

    private static func open(path: String) -> (UnsafeMutablePointer<UInt8>?, Int) {
        guard let file = fopen(path, "rb") else {
            return (nil, 0)
        }
        defer {
            fclose(file)
        }
        if fseeko(file, 0, SEEK_END) != 0 {
            return (nil, 0)
        }
        let size = ftello(file)
        if fseeko(file, 0, SEEK_SET) != 0 {
            return (nil, 0)
        }
        guard size > 0 && size < Int32.max else {
            return (nil, 0)
        }
        var count = Int(size)
        let bytes = UnsafeMutableRawPointer.allocate(byteCount: count,
            alignment: MemoryLayout<UInt8>.alignment)
        count = fread(bytes, 1, count, file)
        return (bytes.assumingMemoryBound(to: UInt8.self), count)
    }
}