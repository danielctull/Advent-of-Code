
import Advent
import Year2020
import XCTest

final class Day18Tests: XCTestCase {

    func testPart1Example() throws {
        XCTAssertEqual(try Day18.part1("1 + 2 * 3 + 4 * 5 + 6"), 71)
        XCTAssertEqual(try Day18.part1("2 * 3 + (4 * 5)"), 26)
        XCTAssertEqual(try Day18.part1("5 + (8 * 3 + 9 + 3 * 4 * 3)"), 437)
        XCTAssertEqual(try Day18.part1("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"), 12240)
        XCTAssertEqual(try Day18.part1("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"), 13632)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day18")
        XCTAssertEqual(try Day18.part1(input), 0)
    }


    func testPart2Example() throws {
        XCTAssertEqual(try Day18.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day18")
        XCTAssertEqual(try Day18.part2(input), 0)
    }
}
