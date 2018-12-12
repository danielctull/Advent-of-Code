
import Advent
import Year2018
import XCTest

final class Day11Tests: XCTestCase {

    func testPart1Example() {
        let result = Day11().part1(input: "18")
        XCTAssertEqual(result, "33,45")
    }

    func testPart1Puzzle() throws {
        let result = Day11().part1(input: "6392")
        XCTAssertEqual(result, "20,58")
    }

    func testPart2Example1() {
        let result = Day11().part2(input: "18")
        XCTAssertEqual(result, "90,269,16")
    }

    func testPart2Example2() {
        let result = Day11().part2(input: "42")
        XCTAssertEqual(result, "232,251,12")
    }

    func testPart2Puzzle() throws {
        let result = Day11().part2(input: "6392")
        XCTAssertEqual(result, "")
    }
}
