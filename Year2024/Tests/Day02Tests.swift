
import Advent
import Year2024
import XCTest

final class Day02Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day02.part1([
          "7 6 4 2 1",
          "1 2 7 8 9",
          "9 7 6 2 1",
          "1 3 2 4 5",
          "8 6 4 4 1",
          "1 3 6 7 9",
        ]), 2)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day02")
        XCTAssertEqual(try Day02.part1(input), 287)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day02.part2([
            "7 6 4 2 1",
            "1 2 7 8 9",
            "9 7 6 2 1",
            "1 3 2 4 5",
            "8 6 4 4 1",
            "1 3 6 7 9",
          ]), 4)

    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day02")
        XCTAssertEqual(try Day02.part2(input), 354)
    }
}
