
import Advent
import Year2020
import XCTest

final class Day17Tests: XCTestCase {

    func testPart1Example() throws {
        XCTAssertEqual(try Day17.part1([
            ".#.",
            "..#",
            "###"
        ]), 112)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day17")
        XCTAssertEqual(try Day17.part1(input), 240)
    }


    func testPart2Example() throws {
        XCTAssertEqual(try Day17.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day17")
        XCTAssertEqual(try Day17.part2(input), 0)
    }
}
