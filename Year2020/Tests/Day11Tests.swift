
import Advent
import Year2020
import XCTest

final class Day11Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day11.part1([
            "L.LL.LL.LL",
            "LLLLLLL.LL",
            "L.L.L..L..",
            "LLLL.LL.LL",
            "L.LL.LL.LL",
            "L.LLLLL.LL",
            "..L.L.....",
            "LLLLLLLLLL",
            "L.LLLLLL.L",
            "L.LLLLL.LL"]), 37)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day11")
        XCTAssertEqual(try Day11.part1(input), 2113)
    }

    func testPart2Example1() throws {
        XCTAssertEqual(try Day11.part2([
            "L.LL.LL.LL",
            "LLLLLLL.LL",
            "L.L.L..L..",
            "LLLL.LL.LL",
            "L.LL.LL.LL",
            "L.LLLLL.LL",
            "..L.L.....",
            "LLLLLLLLLL",
            "L.LLLLLL.L",
            "L.LLLLL.LL"]), 26)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day11")
        XCTAssertEqual(try Day11.part2(input), 1865)
    }
}
