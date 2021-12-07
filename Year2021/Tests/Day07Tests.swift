
import Advent
import Year2021
import XCTest

final class Day07Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day07.part1(["16,1,2,0,4,2,7,1,2,14"]), 37)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        XCTAssertEqual(try Day07.part1(input), 344535)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day07.part2(["16,1,2,0,4,2,7,1,2,14"]), 168)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        XCTAssertEqual(try Day07.part2(input), 95581659)
    }
}
