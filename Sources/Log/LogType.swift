// MIT License
//
// Copyright (c) 2017 qazyn951230 qazyn951230@gmail.com
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

import Dispatch
import Foundation

public protocol LogType {
    static var level: LogLevel { get }
    static var queue: DispatchQueue { get }
    static var dateFormatter: DateFormatter { get }
    static var destinations: [LogDestination] { get set }
    static var separator: String { get }

    static func write(level: LogLevel, _ value: Any, file: String, function: String, line: Int)
    static func write(level: LogLevel, _ value: Any?, file: String, function: String, line: Int)
    static func write(level: LogLevel, _ value: [Any], file: String, function: String, line: Int)
    static func write(level: LogLevel, _ value: [Any?], file: String, function: String, line: Int)

    static func close()
    static func write(message: String)
    static func write(level: LogLevel, message: String, thread: String, date: Date,
                      file: String, function: String, line: Int)

    static func format(level: LogLevel, _ value: Any, separator: String, expand: Bool) -> String
    static func format(level: LogLevel, array: [Any], separator: String) -> String
    static func format(level: LogLevel, dictionary: [AnyHashable: Any], separator: String) -> String
}

public extension LogType {
    public static func close() {
        destinations.forEach {
            $0.close()
        }
        destinations = []
    }

    public static func write(message: String) {
        let destinations = Self.destinations
        queue.async {
            destinations.forEach {
                $0.write(message: message)
            }
        }
    }

    public static func write(level: LogLevel, _ value: Any, file: String, function: String, line: Int) {
        guard level >= Self.level else {
            return
        }
        let message = format(level: level, value, separator: Self.separator)
        var thread: String = Thread.current.name ?? Thread.current.description
        if thread.isEmpty {
            if Thread.isMainThread {
                thread = "main"
            } else if let queue: OperationQueue = OperationQueue.current {
                thread = queue.name ?? queue.underlyingQueue?.label ?? "unnamed"
            }
            if thread.isEmpty {
                thread = Thread.current.description
            }
        }
        write(level: level, message: message, thread: thread, date: Date(), file: file, function: function, line: line)
    }

    public static func write(level: LogLevel, _ value: Any?, file: String, function: String, line: Int) {
        if let v = value {
            write(level: level, v, file: file, function: function, line: line)
        }
    }

    public static func write(level: LogLevel, _ value: [Any], file: String, function: String, line: Int) {
        guard level >= Self.level, value.count > 0 else {
            return
        }
        let message = format(level: level, array: value, separator: Self.separator)
        let thread = Thread.current.name ?? Thread.current.description
        write(level: level, message: message, thread: thread, date: Date(), file: file, function: function, line: line)
    }

    public static func write(level: LogLevel, _ value: [Any?], file: String, function: String, line: Int) {
        let array: [Any] = value.flatMap(Function.this)
        write(level: level, array, file: file, function: function, line: line)
    }

    public static func write(level: LogLevel, message: String, thread: String, date: Date,
                             file: String, function: String, line: Int) {
        let d = dateFormatter.string(from: date)
        let u = URL(fileURLWithPath: file).lastPathComponent
        // MM [main] debug [foo.swift:18]foo() message
        write(message: "\(d) [\(thread)] \(level.description) [\(u):\(line)]\(function)\n\(message)\n")
    }

    public static func format(level: LogLevel, _ value: Any, separator: String, expand: Bool = true) -> String {
        if expand {
            if let d = value as? [Any] {
                return format(level: level, array: d, separator: separator)
            }
            if let e = value as? [AnyHashable: Any] {
                return format(level: level, dictionary: e, separator: separator)
            }
        }
        // FIXME: is this necessary?
        if let c = value as? String {
            return c
        }
        if level > LogLevel.warn, let a = value as? CustomDebugStringConvertible {
            return a.debugDescription
        }
        if let b = value as? CustomStringConvertible {
            return b.description
        }
        return String(describing: value)
    }

    public static func format(level: LogLevel, array: [Any], separator: String) -> String {
        return array.map {
            format(level: level, $0, separator: separator, expand: false)
        }.joined(separator: separator)
    }

    public static func format(level: LogLevel, dictionary: [AnyHashable: Any], separator: String) -> String {
        return dictionary.map { (k, v) in
            return String(describing: k) + format(level: level, v, separator: separator, expand: false)
        }.joined(separator: separator)
    }
}
