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

@testable import StartCore
import XCTest

final class PathTests: XCTestCase {
    func testPathComponents() {
        func pathComponents(_ path: String, components: [String], absolute: Bool,
                            file: StaticString = #file, line: UInt = #line) {
            let (a, b) = Path.pathComponents(path: path)
            XCTAssertEqual(b, components, file: file, line: line)
            XCTAssertEqual(a, absolute, file: file, line: line)
        }

        pathComponents("", components: [], absolute: false)
        pathComponents("/", components: [], absolute: true)
        pathComponents("//", components: [], absolute: true)
        pathComponents("/////////", components: [], absolute: true)

        pathComponents("/a", components: ["a"], absolute: true)
        pathComponents("/a/b", components: ["a", "b"], absolute: true)
        pathComponents("/a//b", components: ["a", "b"], absolute: true)
        pathComponents("/a/////b", components: ["a", "b"], absolute: true)
        pathComponents("/a/c/d/a", components: ["a", "c", "d", "a"], absolute: true)

        pathComponents("a", components: ["a"], absolute: false)
        pathComponents("a/b", components: ["a", "b"], absolute: false)
        pathComponents("a//b", components: ["a", "b"], absolute: false)
        pathComponents("a/////b", components: ["a", "b"], absolute: false)
        pathComponents("a/c/d/a", components: ["a", "c", "d", "a"], absolute: false)
    }

    func testBasename() {
        func basename(_ path: String, ext: String?, result: String,
                      file: StaticString = #file, line: UInt = #line) {
            let name = Path(path).basename(extension: ext)
            XCTAssertEqual(name, result, file: file, line: line)
        }

        basename("/foo.bar", ext: ".b", result: "foo.bar")
        basename("/foo.bar", ext: "/foo.bar", result: "foo.bar")
        basename("/foo.bar", ext: "foo.bar", result: "foo.bar")
        basename("/foo.bar", ext: "o.bar", result: "fo")

        basename(#file, ext: nil, result: "PathTests.swift")
        basename(#file, ext: ".swift", result: "PathTests")
        basename(".swift", ext: ".swift", result: ".swift")
        basename("", ext: nil, result: "")
    }

    func testString() {
        func string(_ path: String, result: String,
                    file: StaticString = #file, line: UInt = #line) {
            XCTAssertEqual(Path(path).string, result, file: file, line: line)
        }

        string("", result: "")
        string("/", result: "/")
        string("/foo", result: "/foo")
        string("/foo.bar", result: "/foo.bar")
        string("///////foo.bar", result: "/foo.bar")
        string("///////foo.bar///////", result: "/foo.bar")
        string("///////foo.bar///////fooo", result: "/foo.bar/fooo")
        string("foo.bar/fooo", result: "foo.bar/fooo")
        string("foo.bar///////fooo", result: "foo.bar/fooo")
        string("./foobar", result: "./foobar")
    }

    func testName() {
        func name(_ path: String, result: String,
                  file: StaticString = #file, line: UInt = #line) {
            XCTAssertEqual(Path(path).name, result, file: file, line: line)
        }

        name("", result: "")
        name("/", result: "")
        name("/foo", result: "foo")
        name("/foo.bar", result: "foo")
        name("/foo.bar", result: "foo")
        name("/foo.bar.ext", result: "foo.bar")
        name("/.foo", result: ".foo")
        name("/.foo/bar", result: "bar")
    }

    func testExtension() {
        func `extension`(_ path: String, result: String,
                         file: StaticString = #file, line: UInt = #line) {
            XCTAssertEqual(Path(path).extension, result, file: file, line: line)
        }

        `extension`("", result: "")
        `extension`("/", result: "")
        `extension`("/foo", result: "")
        `extension`("/foo.bar", result: ".bar")
        `extension`("/foo.bar", result: ".bar")
        `extension`("/foo.bar.ext", result: ".ext")
        `extension`("/.foo", result: "")
        `extension`("/.foo/bar", result: "")
    }

    func testReplaceFilename() {
        func filename(_ path: String, r replacement: String, result: String,
                      file: StaticString = #file, line: UInt = #line) {
            let p = Path(path).replace(filename: replacement)
            XCTAssertEqual(p.string, result, file: file, line: line)
        }

        filename("", r: "a.b", result: "")
        filename("/", r: "a.b", result: "/")
        filename("/foo", r: "a.b", result: "/a.b")
        filename("/foo.bar", r: "a.b", result: "/a.b")
        filename("/foo.bar.ext", r: "a.b", result: "/a.b")
        filename("/.foo", r: "a.b", result: "/a.b")
        filename("/.foo/bar", r: "a.b", result: "/.foo/a.b")
    }

    func testReplaceName() {
        func name(_ path: String, r replacement: String, result: String,
                      file: StaticString = #file, line: UInt = #line) {
            let p = Path(path).replace(name: replacement)
            XCTAssertEqual(p.string, result, file: file, line: line)
        }

        name("", r: "a.b", result: "")
        name("/", r: "a.b", result: "/")
        name("/foo", r: "a.b", result: "/a.b")
        name("/foo.bar", r: "a.b", result: "/a.b.bar")
        name("/foo.bar.ext", r: "a.b", result: "/a.b.ext")
        name("/.foo", r: "a.b", result: "/a.b")
        name("/.foo/bar", r: "a.b", result: "/.foo/a.b")
    }

    func testReplaceExtension() {
        func `extension`(_ path: String, r replacement: String?, result: String,
                         file: StaticString = #file, line: UInt = #line) {
            let p = Path(path).replace(extension: replacement)
            XCTAssertEqual(p.string, result, file: file, line: line)
        }

        `extension`("", r: ".b", result: "")
        `extension`("/", r: ".b", result: "/")
        `extension`("/foo", r: ".b", result: "/foo.b")
        `extension`("/foo.bar", r: ".b", result: "/foo.b")
        `extension`("/foo.bar", r: ".a.b", result: "/foo.a.b")
        `extension`("/foo.bar.ext", r: ".b", result: "/foo.bar.b")
        `extension`("/.foo", r: ".b", result: "/.foo.b")
        `extension`("/.foo/bar", r: ".b", result: "/.foo/bar.b")
    }
}
