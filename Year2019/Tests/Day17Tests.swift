
import Advent
import Year2019
import XCTest

final class Day17Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day17()
        let file = try Input(named: "Day17")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 6244)
    }
}
