
import Advent
import Year2020
import XCTest

final class Day12Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day12.part1("F10,N3,F7,R90,F11"), 25)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day12")
        XCTAssertEqual(try Day12.part1(input), 439)
    }

    func testPart2Example1() throws {
        XCTAssertEqual(try Day12.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day12")
        XCTAssertEqual(try Day12.part2(input), 0)
    }
}
