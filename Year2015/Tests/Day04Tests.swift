
import Advent
import Year2015
import XCTest

final class Day04Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day04.part1("abcdef"), 609043)
        XCTAssertEqual(try Day04.part1("pqrstuv"), 1048970)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day04")
        XCTAssertEqual(try Day04.part1(input), 117946)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day04.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day04")
        XCTAssertEqual(try Day04.part2(input), 0)
    }
}
