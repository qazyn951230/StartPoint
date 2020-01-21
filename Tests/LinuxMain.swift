import XCTest

import StartCoreTests
import StartPointTests

var tests = [XCTestCaseEntry]()
tests += StartCoreTests.allTests()
tests += StartPointTests.allTests()
XCTMain(tests)
