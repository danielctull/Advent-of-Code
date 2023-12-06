
import Advent
import Year2023
import XCTest

final class Day06Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day06.part1([
            """
            Time:      7  15   30
            Distance:  9  40  200
            """
        ]), 288)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(try Day06.part1(input), 588588)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day06.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(try Day06.part2(input), 0)
    }
}
