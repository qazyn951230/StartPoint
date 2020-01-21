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

class JSONTests2: XCTestCase {
    private func decode(_ json: String) -> JSON {
        let decoder = JSONDecoder()
        return try! decoder.decode(JSON.self, from: json.data(using: .utf8)!)
    }

    func testEmptyJSON() {
        let ref = json_create()
        let json = JSON(buffer: JSONBuffer(ref: ref), ref: ref)
        XCTAssertEqual(json, JSON.null)
    }

    func testDecodeArray() {
        XCTAssertEqual(decode("[-1]"), JSON(array: [JSON(-1)]))
    }

    func testDecodeXcodeBuildSettings() {
        let json = """
            {
              "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES" : "YES",
              "BUNDLE_LOADER" : "$(TEST_HOST)",
              "CODE_SIGN_STYLE" : "Automatic",
              "DEVELOPMENT_TEAM" : "F3XBV7X28L",
              "INFOPLIST_FILE" : "FoobarTests\\/Info.plist",
              "IPHONEOS_DEPLOYMENT_TARGET" : "13.1",
              "LD_RUNPATH_SEARCH_PATHS" : [
                "$(inherited)",
                "@executable_path\\/Frameworks",
                "@loader_path\\/Frameworks"
              ],
              "PRODUCT_BUNDLE_IDENTIFIER" : "com.undev.FoobarTests",
              "PRODUCT_NAME" : "$(TARGET_NAME)",
              "SWIFT_VERSION" : "5.0",
              "TARGETED_DEVICE_FAMILY" : "1,2",
              "TEST_HOST" : "$(BUILT_PRODUCTS_DIR)\\/Foobar.app\\/Foobar"
            }
            """
        let result = decode(json)
        let expected = JSON.object()
        expected.set(key: "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES", "YES")
        expected.set(key: "BUNDLE_LOADER", "$(TEST_HOST)")
        expected.set(key: "CODE_SIGN_STYLE", "Automatic")
        expected.set(key: "DEVELOPMENT_TEAM", "F3XBV7X28L")
        expected.set(key: "INFOPLIST_FILE", "FoobarTests/Info.plist")
        expected.set(key: "IPHONEOS_DEPLOYMENT_TARGET", "13.1")
        let paths = JSON.array()
        paths.append("$(inherited)")
        paths.append("@executable_path/Frameworks")
        paths.append("@loader_path/Frameworks")
        expected.set(key: "LD_RUNPATH_SEARCH_PATHS", paths)
        expected.set(key: "PRODUCT_BUNDLE_IDENTIFIER", "com.undev.FoobarTests")
        expected.set(key: "PRODUCT_NAME", "$(TARGET_NAME)")
        expected.set(key: "SWIFT_VERSION", "5.0")
        expected.set(key: "TARGETED_DEVICE_FAMILY", "1,2")
        expected.set(key: "TEST_HOST", "$(BUILT_PRODUCTS_DIR)/Foobar.app/Foobar")
        XCTAssertEqual(result, expected)
    }

    func testDecodeXcodeBuildSettingsPlist() {
        let plist = """
            // !$*UTF8*$!
            {
                ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES = YES;
                BUNDLE_LOADER = "$(TEST_HOST)";
                CODE_SIGN_STYLE = Automatic;
                DEVELOPMENT_TEAM = F3XBV7X28L;
                INFOPLIST_FILE = FoobarTests/Info.plist;
                IPHONEOS_DEPLOYMENT_TARGET = 13.1;
                LD_RUNPATH_SEARCH_PATHS = (
                    "$(inherited)",
                    "@executable_path/Frameworks",
                    "@loader_path/Frameworks",
                    );
                PRODUCT_BUNDLE_IDENTIFIER = com.undev.FoobarTests;
                PRODUCT_NAME = "$(TARGET_NAME)";
                SWIFT_VERSION = 5.0;
                TARGETED_DEVICE_FAMILY = "1,2";
                TEST_HOST = "$(BUILT_PRODUCTS_DIR)/Foobar.app/Foobar";
            }
            """
        let decoder = PropertyListDecoder()
        let result = try! decoder.decode(JSON.self, from: plist.data(using: .utf8)!)
        let expected = JSON.object()
        expected.set(key: "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES", "YES")
        expected.set(key: "BUNDLE_LOADER", "$(TEST_HOST)")
        expected.set(key: "CODE_SIGN_STYLE", "Automatic")
        expected.set(key: "DEVELOPMENT_TEAM", "F3XBV7X28L")
        expected.set(key: "INFOPLIST_FILE", "FoobarTests/Info.plist")
        expected.set(key: "IPHONEOS_DEPLOYMENT_TARGET", "13.1")
        let paths = JSON.array()
        paths.append("$(inherited)")
        paths.append("@executable_path/Frameworks")
        paths.append("@loader_path/Frameworks")
        expected.set(key: "LD_RUNPATH_SEARCH_PATHS", paths)
        expected.set(key: "PRODUCT_BUNDLE_IDENTIFIER", "com.undev.FoobarTests")
        expected.set(key: "PRODUCT_NAME", "$(TARGET_NAME)")
        expected.set(key: "SWIFT_VERSION", "5.0")
        expected.set(key: "TARGETED_DEVICE_FAMILY", "1,2")
        expected.set(key: "TEST_HOST", "$(BUILT_PRODUCTS_DIR)/Foobar.app/Foobar")
        XCTAssertEqual(result, expected)
    }
}
