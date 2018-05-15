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

public struct Log: LogType {
    public static var level: LogLevel = LogLevel.info
    public static var queue: DispatchQueue = DispatchQueue.global(qos: .utility)
    public static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        if level > LogLevel.debug {
            formatter.dateStyle = .long
            formatter.timeStyle = .medium
        } else {
            // TODO: fff
            formatter.dateFormat = "hh:mm:ss"
        }
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    public static var destinations: [LogDestination] = {
        return [FileLogDestination.standardOutput()]
    }()
    public private(set) static var separator: String = " "

//    public static func info(_ value: Any, file: String = #file, function: String = #function, line: Int = #line) {
//        write(level: LogLevel.info, value, file: file, function: function, line: line)
//    }
//
//    public static func info(any value: Any?, file: String = #file, function: String = #function, line: Int = #line) {
//        write(level: LogLevel.info, value, file: file, function: function, line: line)
//    }

    public static func info(_ value: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        write(level: LogLevel.info, value, file: file, function: function, line: line)
    }

    public static func info(any value: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
        write(level: LogLevel.info, value, file: file, function: function, line: line)
    }

//    public static func warn(_ value: Any, file: String = #file, function: String = #function, line: Int = #line) {
//        write(level: LogLevel.warn, value, file: file, function: function, line: line)
//    }
//
//    public static func warn(any value: Any?, file: String = #file, function: String = #function, line: Int = #line) {
//        write(level: LogLevel.warn, value, file: file, function: function, line: line)
//    }

    public static func warn(_ value: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        write(level: LogLevel.warn, value, file: file, function: function, line: line)
    }

    public static func warn(any value: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
        write(level: LogLevel.warn, value, file: file, function: function, line: line)
    }

//    public static func debug(_ value: Any, file: String = #file, function: String = #function, line: Int = #line) {
//        write(level: LogLevel.debug, value, file: file, function: function, line: line)
//    }
//
//    public static func debug(any value: Any?, file: String = #file, function: String = #function, line: Int = #line) {
//        write(level: LogLevel.debug, value, file: file, function: function, line: line)
//    }

    public static func debug(_ value: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        write(level: LogLevel.debug, value, file: file, function: function, line: line)
    }

    public static func debug(any value: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
        write(level: LogLevel.debug, value, file: file, function: function, line: line)
    }

//    public static func error(_ value: Any, file: String = #file, function: String = #function, line: Int = #line) {
//        write(level: LogLevel.error, value, file: file, function: function, line: line)
//    }
//
//    public static func error(any value: Any?, file: String = #file, function: String = #function, line: Int = #line) {
//        write(level: LogLevel.error, value, file: file, function: function, line: line)
//    }

    public static func error(_ value: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        write(level: LogLevel.error, value, file: file, function: function, line: line)
    }

    public static func error(any value: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
        write(level: LogLevel.error, value, file: file, function: function, line: line)
    }
}
