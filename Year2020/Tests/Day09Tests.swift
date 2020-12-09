
import Advent
import Year2020
import XCTest

final class Day09Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day09.part1([
            "35",
            "20",
            "15",
            "25",
            "47",
            "40",
            "62",
            "55",
            "65",
            "95",
            "102",
            "117",
            "150",
            "182",
            "127",
            "219",
            "299",
            "277",
            "309",
            "576"
        ]), 127)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day09")
        XCTAssertEqual(try Day09.part1(input), 29221323)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day09.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day09")
        XCTAssertEqual(try Day09.part2(input), 0)
    }
}
