
import Advent
import Year2020
import XCTest

final class Day06Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(Day06.part1([
            "abc",
            "",
            "a",
            "b",
            "c",
            "",
            "ab",
            "ac",
            "",
            "a",
            "a",
            "a",
            "a",
            "",
            "b"
        ]), 11)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(Day06.part1(input), 6530)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(Day06.part2(input), 0)
    }
}
