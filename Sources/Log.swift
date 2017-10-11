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

import Foundation

public struct Log {
    public static var separator = " "
    public static var terminator = "\n"
#if DEBUG
    public static var debugging = true
#else
    public static var debugging = false
#endif
    private static var output: FileHandle?
    private static var standardOutput = FileHandle.standardOutput

    private init() {
        // Do noting.
    }

    public static func debug(_ value: Any..., file: String = #file, function: String = #function, line: Int = #line) {
        Log.debug(values: value, file: file, function: function, line: line)
    }

    public static func debug(_ value: Any?..., file: String = #file, function: String = #function, line: Int = #line) {
        Log.debug(values: value, file: file, function: function, line: line)
    }

    public static func debug(values: [Any], file: String = #file, function: String = #function, line: Int = #line) {
        guard debugging else {
            return
        }
        log(value: values, file: file, function: function, line: line, destination: output)
    }

    public static func debug(values: [Any?], file: String = #file, function: String = #function, line: Int = #line) {
        let array: [Any] = values.flatMap(Function.this)
        Log.log(value: array, file: file, function: function, line: line, destination: output)
    }

    public static func simulator(_ value: Any...) {
#if (arch(i386) || arch(x86_64)) && os(iOS)
        guard debugging else {
            return
        }
        log(value: value, destination: standardOutput)
#endif
    }

    private static func log(value: [Any], destination: FileHandle? = nil) {
        var string = value.map(info).joined(separator: separator)
        string += terminator
        write(string, destination: destination)
    }

    private static func log(value: [Any], file: String, function: String, line: Int, destination: FileHandle? = nil) {
        var string: String = value.map(info).joined(separator: separator)
        let file = URL(fileURLWithPath: file, isDirectory: false).relativePath
        string = "[\(file):\(line)]\(function)\n\(string)\(terminator)"
        write(string, destination: destination)
    }

    private static func write(_ string: String, destination: FileHandle?) {
        guard let data = string.data(using: .utf8) else {
            return
        }
        let output = destination ?? standardOutput
        output.write(data)
    }

    private static func info(_ value: Any) -> String {
        if let string = value as? String {
            return string
        }
        return String(reflecting: value)
    }
}
