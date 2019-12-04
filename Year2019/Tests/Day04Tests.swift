
import Advent
import Year2019
import XCTest

final class Day04Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day04()
        let file = try Input(named: "Day04")
        let result = day.part1(input: file)
        XCTAssertEqual(result, 1330)
    }
}
