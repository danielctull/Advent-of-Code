
import Advent
import Year2019
import XCTest

final class Day21Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day21()
        let input = try Bundle.module.input(named: "Day21")
        let result = try day.part1(input: input)
        XCTAssertEqual(result, 19356418)
    }

    func testPart2Puzzle() throws {
        let day = Day21()
        let input = try Bundle.module.input(named: "Day21")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 1146440619)
    }
}
