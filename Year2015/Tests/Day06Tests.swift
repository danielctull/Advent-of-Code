
import Advent
import Year2015
import XCTest

final class Day06Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day06.part1([
            "turn on 0,0 through 999,999",
            "toggle 0,0 through 999,0",
            "turn off 499,499 through 500,500",
        ]), 998996)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(try Day06.part1(input), 569999)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day06.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(try Day06.part2(input), 0)
    }
}
