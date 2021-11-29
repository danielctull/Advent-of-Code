
import Advent
import Year2020
import XCTest

final class Day23Tests: XCTestCase {

    func testPart1Example() throws {
        XCTAssertEqual(try Day23.part1("389125467"), 92658374)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day23")
        XCTAssertEqual(try Day23.part1(input), 97632548)
    }

    func testPart2Example() throws {
        XCTAssertEqual(try Day23.part2(""), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day23")
        XCTAssertEqual(try Day23.part2(input), 0)
    }
}
