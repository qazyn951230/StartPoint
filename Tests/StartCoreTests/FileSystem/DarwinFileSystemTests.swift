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

final class DarwinFileSystemTests: XCTestCase {
    let fileSystem = DarwinFileSystem()
    let directory = Path(#file).parent

    func testMakeDirectory() {
        let path = directory.join("foo")
        XCTAssertFalse(fileSystem.exists(directory: path))
        XCTAssertNoThrow(try fileSystem.makeDirectory(path))
        XCTAssertTrue(fileSystem.exists(directory: path))
        XCTAssertNoThrow(try fileSystem.remove(path))
        XCTAssertFalse(fileSystem.exists(directory: path))
    }

    func testDirectoryIterator() {
        let iterator = try! DarwinDirectoryIterator(path: directory, fileSystem: fileSystem)
        var result: [String] = []
        while let next = iterator.next() {
            result.append(next.path.filename)
        }
        XCTAssertEqual(result.sorted(), ["DarwinFileSystemTests.swift", "PathTests.swift"])
    }

    func testDirectoryIterator2() {
        let iterator = try! DarwinDirectoryIterator(path: directory.parent, fileSystem: fileSystem)
        var result: [String] = []
        while let next = iterator.next() {
            result.append(next.path.filename)
        }
        XCTAssertEqual(result.sorted(), ["Codable", "Extension", "FileSystem", "Layout", "React",
                                         "Resouces", "Router", "Stream", "Thread", "info.plist"])
    }
}
