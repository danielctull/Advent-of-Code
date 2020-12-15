
import Advent
import Year2020
import XCTest

final class Day15Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day15.part1("0,3,6"), 436)
        XCTAssertEqual(try Day15.part1("1,3,2"), 1)
        XCTAssertEqual(try Day15.part1("2,1,3"), 10)
        XCTAssertEqual(try Day15.part1("1,2,3"), 27)
        XCTAssertEqual(try Day15.part1("2,3,1"), 78)
        XCTAssertEqual(try Day15.part1("3,2,1"), 438)
        XCTAssertEqual(try Day15.part1("3,1,2"), 1836)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day15")
        XCTAssertEqual(try Day15.part1(input), 1009)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day15.part2("0,3,6"), 175594)
        XCTAssertEqual(try Day15.part2("1,3,2"), 2578)
        XCTAssertEqual(try Day15.part2("2,1,3"), 3544142)
        XCTAssertEqual(try Day15.part2("1,2,3"), 261214)
        XCTAssertEqual(try Day15.part2("2,3,1"), 6895259)
        XCTAssertEqual(try Day15.part2("3,2,1"), 18)
        XCTAssertEqual(try Day15.part2("3,1,2"), 362)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day15")
        XCTAssertEqual(try Day15.part2(input), 62714)
    }
}
