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

public enum LogLevel: Int, Comparable, CustomStringConvertible {
    case off = 0
    case error = 10
    case warn = 50
    case info = 80
    case debug = 90
    case verbose = 100

    public var description: String {
        switch self {
        case .off:
            return "OFF"
        case .verbose:
            return "VERBOSE"
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO"
        case .warn:
            return "WARN"
        case .error:
            return "ERROR"
        }
    }

    public static func ==(lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    public static func <(lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public static func <=(lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue <= rhs.rawValue
    }

    public static func >=(lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue >= rhs.rawValue
    }

    public static func >(lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue > rhs.rawValue
    }
}
