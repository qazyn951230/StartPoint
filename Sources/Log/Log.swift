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

import Foundation
import Dispatch

public final class Log {
#if DEBUG
    public static let global = Log(tag: "global", level: .verbose, destinations: [FileHandle.standardOutput])
#else
    public static let global = Log(tag: "global", level: .off, destinations: [FileHandle.standardOutput])
#endif

    public var level: LogLevel
    public var destinations: [LogDestination]
    public var waitGroup: DispatchGroup?
    // Default is a single space.
    private let separator: String = "\u{0020}"
    // Default is a single '\n'
    private let newline: [UInt8] = [0x0a]
#if os(iOS)
    private let dateFormatter = DateFormatter()
#else
    private let dateFormatter = ISO8601DateFormatter()
#endif
    private let queue: DispatchQueue
    private let tag: String

    public convenience init(tag: String, level: LogLevel, destination: LogDestination...) {
        assert(!tag.isEmpty)
        self.init(tag: tag, level: level, destinations: destination)
    }

    private init(tag: String, level: LogLevel, destinations: [LogDestination]) {
        self.level = level
        self.destinations = destinations
        self.tag = tag.isEmpty ? "com.undev.log" : ("com.undev.log." + tag)
        queue = DispatchQueue(label: self.tag, qos: .utility)
    }

    public func verbose(_ value: Any..., file: String = #file, function: String = #function,
                        line: UInt = #line, column: UInt = #column) {
        write(value, level: .verbose, file, function, line, column)
    }

    public func verbose(any value: Any?..., file: String = #file, function: String = #function,
                        line: UInt = #line, column: UInt = #column) {
        write(any: value, level: .verbose, file, function, line, column)
    }

    public func debug(_ value: Any..., file: String = #file, function: String = #function,
                      line: UInt = #line, column: UInt = #column) {
        write(value, level: .debug, file, function, line, column)
    }

    public func debug(any value: Any?..., file: String = #file, function: String = #function,
                      line: UInt = #line, column: UInt = #column) {
        write(any: value, level: .debug, file, function, line, column)
    }

    public func info(_ value: Any..., file: String = #file, function: String = #function,
                     line: UInt = #line, column: UInt = #column) {
        write(value, level: .info, file, function, line, column)
    }

    public func info(any value: Any?..., file: String = #file, function: String = #function,
                     line: UInt = #line, column: UInt = #column) {
        write(any: value, level: .info, file, function, line, column)
    }

    public func warn(_ value: Any..., file: String = #file, function: String = #function,
                     line: UInt = #line, column: UInt = #column) {
        write(value, level: .warn, file, function, line, column)
    }

    public func warn(any value: Any?..., file: String = #file, function: String = #function,
                     line: UInt = #line, column: UInt = #column) {
        write(any: value, level: .warn, file, function, line, column)
    }

    public func error(_ value: Any..., file: String = #file, function: String = #function,
                      line: UInt = #line, column: UInt = #column) {
        write(value, level: .error, file, function, line, column)
    }

    public func error(any value: Any?..., file: String = #file, function: String = #function,
                      line: UInt = #line, column: UInt = #column) {
        write(any: value, level: .error, file, function, line, column)
    }

    @inline(__always)
    private func write(_ value: [Any], level: LogLevel, _ file: String,
                       _ function: String, _ line: UInt, _ column: UInt) {
        guard self.level >= level && self.level > LogLevel.off else {
            return
        }
        write(value: value, level, file, function, line, column)
    }

    @inline(__always)
    private func write(any value: [Any?], level: LogLevel, _ file: String,
                       _ function: String, _ line: UInt, _ column: UInt) {
        guard self.level >= level && self.level > LogLevel.off else {
            return
        }
        let array: [Any] = value.compactMap { $0 }
        write(value: array, level, file, function, line, column)
    }

    // Date [Thread] Level [file:line:column] function
    // message lines
    @inline(__always)
    private func write(value: [Any], _ level: LogLevel, _ file: String,
                       _ function: String, _ line: UInt, _ column: UInt) {
        assert(level != LogLevel.off)
        waitGroup?.enter()
        let header = self.header(level, file, function, line, column)
        queue.async {
            var data = Data()
            if let _header = header.data(using: .utf8) {
                data.append(contentsOf: _header)
                data.append(contentsOf: self.newline)
            }
            for item in value {
//                self.format(item, in: &data, expand: false)
                self.format(item, in: &data)
                data.append(contentsOf: self.newline)
            }
            self.destinations.forEach {
                $0.write(data)
            }
            self.waitGroup?.leave()
        }
    }

    // Date [Thread] Level [file:line:column] function
    @inline(__always)
    private func header(_ level: LogLevel, _ file: String,
                        _ function: String, _ line: UInt, _ column: UInt) -> String {
        var array: [String] = [dateFormatter.string(from: Date())]
        array.append(level.description)
        if Thread.isMainThread {
            array.append("[main]")
        } else {
            let name = Thread.current.name ?? tag
            array.append("[\(name)]")
        }
        array.append("[\(file):\(line):\(column)]")
        array.append(function)
        return array.joined(separator: separator)
    }

    @inline(__always)
    private func format(_ value: Any, in data: inout Data, expand: Bool) {
        if expand {
            if let list = value as? [Any] {
                data.append(0x5b) // '['
                for item in list {
                    format(item, in: &data)
                    data.append(0x2c) // ','
                }
                data.append(0x5c) // ']'
                return
            } else if let list = value as? [AnyHashable: Any] {
                data.append(0x7b) // '{'
                for (key, item) in list {
                    format(key, in: &data)
                    data.append(0x2c) // ','
                    data.append(contentsOf: newline)
                    format(item, in: &data)
                }
                data.append(0x7c) // '}'
                return
            }
        }
        format(value, in: &data)
    }

    @inline(__always)
    private func format(_ value: Any, in data: inout Data) {
        let result: String
        if let text = value as? String {
            result = text
        } else if level > LogLevel.info, let dev = value as? CustomDebugStringConvertible {
            result = dev.debugDescription
        } else if let con = value as? CustomStringConvertible {
            result = con.description
        } else {
            result = String(describing: value)
        }
        if let temp = result.data(using: .utf8) {
            data.append(temp)
        }
    }

    public static func make<Subject>(type: Subject.Type, level: LogLevel? = nil,
                                     destinations: [LogDestination]? = nil) -> Log {
        let tag = String(describing: type)
        let _level = level ?? global.level
        let _destinations = destinations ?? [FileHandle.standardOutput]
        return Log(tag: tag, level: _level, destinations: _destinations)
    }

    public static func verbose(_ value: Any..., file: String = #file, function: String = #function,
                        line: UInt = #line, column: UInt = #column) {
        global.write(value, level: .verbose, file, function, line, column)
    }

    public static func verbose(any value: Any?..., file: String = #file, function: String = #function,
                        line: UInt = #line, column: UInt = #column) {
        global.write(any: value, level: .verbose, file, function, line, column)
    }

    public static func debug(_ value: Any..., file: String = #file, function: String = #function,
                      line: UInt = #line, column: UInt = #column) {
        global.write(value, level: .debug, file, function, line, column)
    }

    public static func debug(any value: Any?..., file: String = #file, function: String = #function,
                      line: UInt = #line, column: UInt = #column) {
        global.write(any: value, level: .debug, file, function, line, column)
    }

    public static func info(_ value: Any..., file: String = #file, function: String = #function,
                     line: UInt = #line, column: UInt = #column) {
        global.write(value, level: .info, file, function, line, column)
    }

    public static func info(any value: Any?..., file: String = #file, function: String = #function,
                     line: UInt = #line, column: UInt = #column) {
        global.write(any: value, level: .info, file, function, line, column)
    }

    public static func warn(_ value: Any..., file: String = #file, function: String = #function,
                     line: UInt = #line, column: UInt = #column) {
        global.write(value, level: .warn, file, function, line, column)
    }

    public static func warn(any value: Any?..., file: String = #file, function: String = #function,
                     line: UInt = #line, column: UInt = #column) {
        global.write(any: value, level: .warn, file, function, line, column)
    }

    public static func error(_ value: Any..., file: String = #file, function: String = #function,
                      line: UInt = #line, column: UInt = #column) {
        global.write(value, level: .error, file, function, line, column)
    }

    public static func error(any value: Any?..., file: String = #file, function: String = #function,
                      line: UInt = #line, column: UInt = #column) {
        global.write(any: value, level: .error, file, function, line, column)
    }
}
