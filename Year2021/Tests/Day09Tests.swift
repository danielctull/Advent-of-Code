
import Advent
import Year2021
import XCTest

final class Day09Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day09.part1([
            "2199943210",
            "3987894921",
            "9856789892",
            "8767896789",
            "9899965678",
        ]), 15)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day09")
        XCTAssertEqual(try Day09.part1(input), 494)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day09.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day09")
        XCTAssertEqual(try Day09.part2(input), 0)
    }
}
