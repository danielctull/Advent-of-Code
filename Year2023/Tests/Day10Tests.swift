
import Advent
import Year2023
import XCTest

final class Day10Tests: XCTestCase {

    func testPart1Example1() throws {
        XCTAssertEqual(try Day10.part1([
            ".....",
            ".S-7.",
            ".|.|.",
            ".L-J.",
            ".....",
        ]), 4)
    }

    func testPart1Example2() throws {
        XCTAssertEqual(try Day10.part1([
            "..F7.",
            ".FJ|.",
            "SJ.L7",
            "|F--J",
            "LJ...",
        ]), 8)
    }

    func testPart1Example3() throws {
        XCTAssertEqual(try Day10.part1([
            "7-F7-",
            ".FJ|7",
            "SJLL7",
            "|F--J",
            "LJ.LJ",
        ]), 8)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day10")
        XCTAssertEqual(try Day10.part1(input), 7063)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day10.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day10")
        XCTAssertEqual(try Day10.part2(input), 0)
    }
}
