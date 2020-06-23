
import Advent
import Year2019
import XCTest

final class Day17Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day17()
        let input = try Bundle.module.input(named: "Day17")
        let result = try day.part1(input: input)
        XCTAssertEqual(result, 6244)
    }
}
