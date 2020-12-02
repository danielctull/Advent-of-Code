
import Advent
import Year2020
import XCTest

final class Day02Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day02.part1([
            "1-3 a: abcde",
            "1-3 b: cdefg",
            "2-9 c: ccccccccc"]), 2)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day02")
        XCTAssertEqual(try Day02.part1(input), 628)
    }

    func testPart2Examples() throws {
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day02")
        XCTAssertEqual(try Day02.part2(input), 0)
    }
}
