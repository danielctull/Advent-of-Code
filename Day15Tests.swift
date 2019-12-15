
import Advent
import Year2019
import XCTest

final class Day15Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day15()
        let file = try Input(named: "Day15")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 0)
    }
}
