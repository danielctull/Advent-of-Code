
import Advent
import Year2020
import XCTest

final class Day03Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day03.part1([
            "..##.......",
            "#...#...#..",
            ".#....#..#.",
            "..#.#...#.#",
            ".#...##..#.",
            "..#.##.....",
            ".#.#.#....#",
            ".#........#",
            "#.##...#...",
            "#...##....#",
            ".#..#...#.#"]), 7)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        measure {
            XCTAssertEqual(try! Day03.part1(input), 187)
        }
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day03.part2([
            "..##.......",
            "#...#...#..",
            ".#....#..#.",
            "..#.#...#.#",
            ".#...##..#.",
            "..#.##.....",
            ".#.#.#....#",
            ".#........#",
            "#.##...#...",
            "#...##....#",
            ".#..#...#.#"]), 336)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        measure {
            XCTAssertEqual(try! Day03.part2(input), 4723283400)
        }
    }
}
