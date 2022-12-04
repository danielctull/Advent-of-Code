
import Advent
import Year2022
import XCTest

final class Day04Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day04.part1([
            "2-4,6-8",
            "2-3,4-5",
            "5-7,7-9",
            "2-8,3-7",
            "6-6,4-6",
            "2-6,4-8",
        ]), 2)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day04")
        XCTAssertEqual(try Day04.part1(input), 644)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day04.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day04")
        XCTAssertEqual(try Day04.part2(input), 0)
    }
}
