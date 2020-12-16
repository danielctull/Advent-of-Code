
import Advent
import Year2020
import XCTest

final class Day16Tests: XCTestCase {

    func testPart1Example() throws {
        XCTAssertEqual(try Day16.part1([
            "class: 1-3 or 5-7",
            "row: 6-11 or 33-44",
            "seat: 13-40 or 45-50",
            "",
            "your ticket:",
            "7,1,14",
            "",
            "nearby tickets:",
            "7,3,47",
            "40,4,50",
            "55,2,20",
            "38,6,12"
        ]), 71)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day16")
        XCTAssertEqual(try Day16.part1(input), 26053)
    }


    func testPart2Examples() throws {
        XCTAssertEqual(try Day16.part2([
            "class: 0-1 or 4-19",
            "departure row: 0-5 or 8-19",
            "departure seat: 0-13 or 16-19",
            "",
            "your ticket:",
            "11,12,13",
            "",
            "nearby tickets:",
            "3,9,18",
            "15,1,5",
            "5,14,9"
        ]), 143)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day16")
        XCTAssertEqual(try Day16.part2(input), 1515506256421)
    }
}
