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

public protocol StructureWriter: class {
    associatedtype Output

    var output: Output { get }

    func writeNull()

    func startArray()
    func endArray()

    func startObject()
    func endObject()

    func writePrefix()
    func writeInfix()
    func writeSuffix()

    func write(any value: String?)
    func write(any value: Bool?)
    func write(any value: Float?)
    func write(any value: Double?)
    func write(any value: Int?)
    func write(any value: Int8?)
    func write(any value: Int16?)
    func write(any value: Int32?)
    func write(any value: Int64?)
    func write(any value: UInt?)
    func write(any value: UInt8?)
    func write(any value: UInt16?)
    func write(any value: UInt32?)
    func write(any value: UInt64?)

    func write(_ value: String)
    func write(_ value: Bool)
    func write(_ value: Float)
    func write(_ value: Double)
    func write(_ value: Int)
    func write(_ value: Int8)
    func write(_ value: Int16)
    func write(_ value: Int32)
    func write(_ value: Int64)
    func write(_ value: UInt)
    func write(_ value: UInt8)
    func write(_ value: UInt16)
    func write(_ value: UInt32)
    func write(_ value: UInt64)
}

public extension StructureWriter {
    func write(_ value: Int) {
#if arch(arm64) || arch(x86_64)
        self.write(Int64(value))
#else
        self.write(Int32(value))
#endif
    }

    func write(_ value: Int8) {
        self.write(Int32(value))
    }

    func write(_ value: Int16) {
        self.write(Int32(value))
    }

    func write(_ value: UInt) {
#if arch(arm64) || arch(x86_64)
        self.write(UInt64(value))
#else
        self.write(UInt32(value))
#endif
    }

    func write(_ value: UInt8) {
        self.write(UInt32(value))
    }

    func write(_ value: UInt16) {
        self.write(UInt32(value))
    }

    func write(any value: String?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Bool?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Float?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Double?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int8?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int16?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int32?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: Int64?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt8?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt16?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt32?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    func write(any value: UInt64?) {
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }
}
