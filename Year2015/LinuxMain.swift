import XCTest

import Year2015_Tests
import Year2018_Tests
import Year2019_Tests

var tests = [XCTestCaseEntry]()
tests += Year2015_Tests.__allTests()
tests += Year2018_Tests.__allTests()
tests += Year2019_Tests.__allTests()

XCTMain(tests)
