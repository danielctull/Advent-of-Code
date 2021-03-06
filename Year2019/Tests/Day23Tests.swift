
import Advent
import Year2019
import XCTest

final class Day23Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day23()
        let input = try Bundle.module.input(named: "Day23")
        let result = try day.part1(input: input)
        XCTAssertEqual(result, 18604)
    }

    func testPart2Puzzle() throws {
        let day = Day23()
        let input = try Bundle.module.input(named: "Day23")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 11880)
    }
}
