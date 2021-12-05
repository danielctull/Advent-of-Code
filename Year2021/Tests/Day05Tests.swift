
import Advent
import Year2021
import XCTest

final class Day05Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day05.part1([
            "0,9 -> 5,9",
            "8,0 -> 0,8",
            "9,4 -> 3,4",
            "2,2 -> 2,1",
            "7,0 -> 7,4",
            "6,4 -> 2,0",
            "0,9 -> 2,9",
            "3,4 -> 1,4",
            "0,0 -> 8,8",
            "5,5 -> 8,2",
        ]), 5)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        XCTAssertEqual(try Day05.part1(input), 4873)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day05.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        XCTAssertEqual(try Day05.part2(input), 0)
    }
}
