
import Advent
import Year2021
import XCTest

final class Day06Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day06.part1(["3,4,3,1,2"]), 5934)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(try Day06.part1(input), 375482)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day06.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(try Day06.part2(input), 0)
    }
}
