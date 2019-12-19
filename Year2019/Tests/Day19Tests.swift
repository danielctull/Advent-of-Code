
import Advent
import Year2019
import XCTest

final class Day19Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day19()
        let file = try Input(named: "Day19")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 164)
    }

    func testPart2Puzzle() throws {
        let day = Day19()
        let file = try Input(named: "Day19")
        let result = try day.part2(input: file)
        XCTAssertEqual(result, 13081049)
    }
}
