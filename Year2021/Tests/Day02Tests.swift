
import Advent
import Year2021
import XCTest

final class Day02Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day02.part1([
            "forward 5",
            "down 5",
            "forward 8",
            "up 3",
            "down 8",
            "forward 2",
        ]), 150)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day02")
        XCTAssertEqual(try Day02.part1(input), 1499229)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day02.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day02")
        XCTAssertEqual(try Day02.part2(input), 0)
    }
}
