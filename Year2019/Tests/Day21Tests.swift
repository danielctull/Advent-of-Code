
import Advent
import Year2019
import XCTest

final class Day21Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day21()
        let file = try Input(named: "Day21")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 19356418)
    }

    func testPart2Puzzle() throws {
        let day = Day21()
        let file = try Input(named: "Day21")
        let result = try day.part2(input: file)
        XCTAssertEqual(result, 1146440619)
    }
}
