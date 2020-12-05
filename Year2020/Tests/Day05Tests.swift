
import Advent
import Year2020
import XCTest

final class Day05Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day05.part1("FBFBBFFRLR"), 357)
        XCTAssertEqual(try Day05.part1("BFFFBBFRRR"), 567)
        XCTAssertEqual(try Day05.part1("FFFBBBFRRR"), 119)
        XCTAssertEqual(try Day05.part1("BBFFBBFRLL"), 820)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        XCTAssertEqual(try Day05.part1(input), 842)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        XCTAssertEqual(Day05.part2(input), 617)
    }
}
