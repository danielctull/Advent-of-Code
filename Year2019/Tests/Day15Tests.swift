
import Advent
import Year2019
import XCTest

final class Day15Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day15()
        let input = try Bundle.module.input(named: "Day15")
        let result = try day.part1(input: input)
        XCTAssertEqual(result, 232)
    }

    func testPart2Puzzle() throws {
        let day = Day15()
        let input = try Bundle.module.input(named: "Day15")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 320)
    }
}
