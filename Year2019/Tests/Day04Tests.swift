
import Advent
import Year2019
import XCTest

final class Day04Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day04()
        let input = try Bundle.module.input(named: "Day04")
        let result = day.part1(input: input)
        XCTAssertEqual(result, 1330)
    }

    func testPart2Puzzle() throws {
        let day = Day04()
        let input = try Bundle.module.input(named: "Day04")
        let result = day.part2(input: input)
        XCTAssertEqual(result, 876)
    }
}
