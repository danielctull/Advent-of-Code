import XCTest

import Year2015_Tests
import Year2018_Tests

var tests = [XCTestCaseEntry]()
tests += Year2015_Tests.__allTests()
tests += Year2018_Tests.__allTests()

// Filter out all the puzzles because they load a file from disk
tests = tests.filter { !$0.0.contains("Puzzle") }

XCTMain(tests)
