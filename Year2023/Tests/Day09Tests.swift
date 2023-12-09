
import Advent
import Year2023
import XCTest

final class Day09Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day09.part1([
            "0 3 6 9 12 15",
            "1 3 6 10 15 21",
            "10 13 16 21 30 45",
        ]), 114)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day09")
        XCTAssertEqual(try Day09.part1(input), 1789635132)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day09.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day09")
        XCTAssertEqual(try Day09.part2(input), 0)
    }
}
