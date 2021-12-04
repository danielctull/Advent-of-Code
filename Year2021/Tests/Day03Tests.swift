
import Advent
import Year2021
import XCTest

final class Day03Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day03.part1([
            "00100",
            "11110",
            "10110",
            "10111",
            "10101",
            "01111",
            "00111",
            "11100",
            "10000",
            "11001",
            "00010",
            "01010",
        ]), 198)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        XCTAssertEqual(try Day03.part1(input), 841526)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day03.part2([
            "00100",
            "11110",
            "10110",
            "10111",
            "10101",
            "01111",
            "00111",
            "11100",
            "10000",
            "11001",
            "00010",
            "01010",
        ]), 230)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        XCTAssertEqual(try Day03.part2(input), 4790390)
    }
}
