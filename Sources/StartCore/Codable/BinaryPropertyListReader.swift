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

// https://opensource.apple.com/source/CF/CF-1153.18/CFBinaryPList.c.auto.html
final class BinaryPropertyListReader: PropertyListReader {
    var stream: AnyByteStream
    var offsetWidth: Int = 0
    var referenceWidth: Int = 0
    var objectCount: Int = 0
    var rootObjectIndex: Int = 0
    var offsetTableStart: Int = 0
    var offsetTable: [Int] = []
    // Offset => PropertyList
    var objects: [Int: PropertyList] = [:]

    init(stream: AnyByteStream) {
        self.stream = stream
        super.init()
    }

    override func read() {
        _ = readHeader()
        _ = readFooter()
        _ = readOffsetTable()
        let root = readRootObject()
        print(root)
    }

    private func readHeader() -> Bool {
        guard let raw = stream.peek(count: Header.size) else {
            return false
        }
        stream.move(offset: Header.size)
        let header = Header(bytes: raw)
        return header.valid
    }

    private func readFooter() -> Bool {
        stream.seek(offset: -Footer.size, direction: .end)
        guard let raw = stream.peek(count: Footer.size) else {
            return false
        }
        stream.move(offset: Footer.size)
        let footer = Footer(bytes: raw)
        offsetWidth = footer.offsetWidth
        referenceWidth = footer.referenceWidth
        objectCount = footer.objectCount
        rootObjectIndex = footer.rootObjectIndex
        offsetTableStart = footer.offsetTableStart
        return true
    }

    private func readOffsetTable() -> Bool {
        assert(offsetTable.isEmpty)
        stream.seek(offset: offsetTableStart, direction: .start)
        offsetTable.reserveCapacity(objectCount)
        objects.reserveCapacity(objectCount)
        for _ in 0..<objectCount {
            let offset = readInt(size: offsetWidth)
            offsetTable.append(offset)
        }
        return true
    }

    func readObject(index: Int) -> PropertyList {
        guard let offset = offsetTable.object(at: index) else {
            return PropertyList.null
        }
        if let cached = objects[offset] {
            return cached
        }
        stream.seek(offset: offset, direction: .start)
        let object = readObject()
        objects[offset] = object
        return object
    }

    private func readObject() -> PropertyList {
        let byte = stream.take()
        switch BinaryPropertyListReader.objectKind(byte: byte) {
        case .null:
            return PropertyList.null
        case .boolFalse:
            return PropertyListBool(false)
        case .boolTrue:
            return PropertyListBool(true)
        case .fill:
            return PropertyList.null
        case .date:
            return readDate()
        case .integer:
            return readInteger(size: 1 << Int(byte & 0x0f))
        case .real:
            return readReal(size: 1 << Int(byte & 0x0f))
        case .data:
            return readData(size: Int(byte & 0x0f))
        case .ascii:
            return readASCIIString(size: Int(byte & 0x0f))
        case .unicode:
            return readUTF16String(size: Int(byte & 0x0f))
        case .uid:
            return readUID(size: Int(byte & 0x0f) + 1)
        case .array:
            return readArray(size: Int(byte & 0x0f))
        case .dictionary:
            return readDictionary(size: Int(byte & 0x0f))
        case .unknown:
            return PropertyList.null
        }
    }

    func readRootObject() -> PropertyList {
        return readObject(index: rootObjectIndex)
    }

    private func readDate() -> PropertyListDate {
        let time = readUInt64(size: 8)
        return PropertyListDate(since20010101: time)
    }

    private func readInteger(size: Int) -> PropertyListInteger {
        let value = readUInt64(size: size)
        return PropertyListInteger(value)
    }

    private func readReal(size: Int) -> PropertyListReal {
        let value = readUInt64(size: size)
        switch size {
        case 8:
            return PropertyListReal(Double(bitPattern: value))
        case 4:
            let float = Float(bitPattern: UInt32(value))
            return PropertyListReal(Double(float))
        default:
            return PropertyListReal(0.0)
        }
    }

    private func readData(size: Int) -> PropertyListData {
        let length = readLength(size: size)
        var data = Data()
        if length > 0, let raw = stream.peek(count: length) {
            data.append(raw, count: length)
        }
        return PropertyListData(data)
    }

    private func readASCIIString(size: Int) -> PropertyListString {
        let length = readLength(size: size) * MemoryLayout<UInt8>.size
        var data = Data()
        if length > 0, let raw = stream.peek(count: length) {
            data.append(raw, count: length)
        }
        let text = String(data: data, encoding: .ascii)
        return PropertyListString(text ?? "")
    }

    private func readUTF16String(size: Int) -> PropertyListString {
        let length = readLength(size: size) * MemoryLayout<UInt16>.size
        var data = Data()
        if length > 0, let raw = stream.peek(count: length) {
            data.append(raw, count: length)
        }
        let text = String(data: data, encoding: .utf16BigEndian)
        return PropertyListString(text ?? "")
    }

    private func readUID(size: Int) -> PropertyListUID {
        let length = readLength(size: size)
        if length > 4 || length < 1 {
            return PropertyListUID(0)
        }
        let value = readUInt64(size: length)
        return PropertyListUID(UInt32(value))
    }

    private func readArray(size: Int) -> PropertyListArray {
        let length = readLength(size: size)
        var list: [Int] = []
        list.reserveCapacity(length)
        for _ in 0..<length {
            let offset = readReference()
            list.append(offset)
        }
        var array: [PropertyList] = []
        array.reserveCapacity(length)
        for index in list {
            let object = readObject(index: index)
            array.append(object)
        }
        return PropertyListArray(array)
    }

    private func readDictionary(size: Int) -> PropertyListDictionary {
        let length = readLength(size: size)
        var keys: [Int] = []
        keys.reserveCapacity(length)
        for _ in 0..<length {
            let keyRef = readReference()
            keys.append(keyRef)
        }
        var values: [Int] = []
        values.reserveCapacity(length)
        for _ in 0..<length {
            let valueRef = readReference()
            values.append(valueRef)
        }
        var dictionary: [String: PropertyList] = [:]
        dictionary.reserveCapacity(length)
        for i in 0..<length {
            let keyRef = keys[i]
            let valueRef = values[i]
            let key = readObject(index: keyRef)
            if let string = key as? PropertyListString {
                let value = readObject(index: valueRef)
                dictionary[string.value] = value
            }
        }
        return PropertyListDictionary(dictionary)
    }

    private func readLength(size: Int) -> Int {
        if size != 0x0f {
            return size
        }
        let marker = stream.take()
        if marker & 0xf0 == 0x10 {
            return readInt(size: 1 << Int(marker & 0x0f))
        }
        return 0
    }

    private func readOffset() -> Int {
        return readInt(size: offsetWidth)
    }

    private func readReference() -> Int {
        return readInt(size: referenceWidth)
    }

    static func objectKind(byte: UInt8) -> PropertyListKind {
        if byte & 0xf0 == 0 {
            switch byte {
            case 0x00:
                return PropertyListKind.null
            case 0x08:
                return PropertyListKind.boolFalse
            case 0x09:
                return PropertyListKind.boolTrue
            case 0x0f:
                return PropertyListKind.fill
            default:
                return PropertyListKind.unknown
            }
        } else if byte == 0x33 {
            return PropertyListKind.date
        } else {
            switch byte >> 4 {
            case 0x01:
                return PropertyListKind.integer
            case 0x02:
                return PropertyListKind.real
            case 0x04:
                return PropertyListKind.data
            case 0x05:
                return PropertyListKind.ascii
            case 0x06:
                return PropertyListKind.unicode
            case 0x08:
                return PropertyListKind.uid
            case 0x0a:
                return PropertyListKind.array
            case 0x0d:
                return PropertyListKind.dictionary
            default:
                return PropertyListKind.unknown
            }
        }
    }

    private func readUInt64(size: Int) -> UInt64 {
        var result: UInt64 = 0
        var i: UInt64 = UInt64(size)
        while i > 0 && i < 9 {
            i -= 1
            result |= UInt64(stream.take()) << (i * 8)
        }
        return result
    }

    private func readInt(size: Int) -> Int {
        return Int(readUInt64(size: size))
    }

    private struct Header {
        static let size = 8
        // char magic[6]
        let magic: String
        // char version[2]
        let version: String

        init(bytes: UnsafePointer<UInt8>) {
            var raw = UnsafeRawPointer(bytes)
            let data = Data(bytes: raw, count: 6)
            magic = String(data: data, encoding: .ascii) ?? ""
            raw = raw.advanced(by: 6)
            let data2 = Data(bytes: raw, count: 2)
            version = String(data: data2, encoding: .ascii) ?? ""
        }
        
        var valid: Bool {
            return magic == "bplist" && version == "00"
        }
    }

    private struct Footer {
        static let size = 32
        // uint8_t fill[6]
        // uint8_t offsetWidth
        let offsetWidth: Int
        // uint8_t referenceWidth
        let referenceWidth: Int
        // uint64_t objectCount
        let objectCount: Int
        // uint64_t rootObjectIndex
        let rootObjectIndex: Int
        // uint64_t offsetTableStart
        let offsetTableStart: Int

        init(bytes: UnsafePointer<UInt8>) {
            // Skip first 6 bytes
            var raw = bytes.advanced(by: 6)
            offsetWidth = Int(raw.pointee)
            raw = raw.successor()
            referenceWidth = Int(raw.pointee)
            raw = raw.successor()
            var raw2 = UnsafeRawPointer(raw).bindMemory(to: UInt64.self, capacity: 3)
            objectCount = Int(raw2.pointee.bigEndian)
            raw2 = raw2.successor()
            rootObjectIndex = Int(raw2.pointee.bigEndian)
            raw2 = raw2.successor()
            offsetTableStart = Int(raw2.pointee.bigEndian)
        }
    }
}
