
import Advent
import Year2020
import XCTest

final class Day13Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day13.part1(["939","7,13,x,x,59,x,31,19"]), 295)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day13")
        XCTAssertEqual(try Day13.part1(input), 2845)
    }

    func testPart2Example1() throws {
        XCTAssertEqual(try Day13.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day13")
        XCTAssertEqual(try Day13.part2(input), 0)
    }
}
