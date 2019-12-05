
import Advent
import Year2019
import XCTest

final class Day05Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day05()
        let file = try Input(named: "Day05")
        let result = day.part1(input: file)
        XCTAssertEqual(result, 9006673)
    }
//
//    func testPart2Puzzle() throws {
//        let day = Day05()
//        let file = try Input(named: "Day05")
//        let result = day.part2(input: file)
//        XCTAssertEqual(result, 0)
//    }
}
