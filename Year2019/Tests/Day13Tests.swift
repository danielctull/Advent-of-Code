
import Advent
import Year2019
import XCTest

final class Day13Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day13()
        let input = try Bundle.module.input(named: "Day13")
        let result = try day.part1(input: input)
        XCTAssertEqual(result, 432)
    }

    func testPart2Puzzle() throws {
        let day = Day13()
        let input = try Bundle.module.input(named: "Day13")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 22225)
    }
}
