
import Advent
import Year2018
import XCTest

final class Day12Tests: XCTestCase {

    func testPart1Example() {
        let result = Day12().part1(input: [
            "initial state: #..#.#..##......###...###",
            "",
            "...## => #",
            "..#.. => #",
            ".#... => #",
            ".#.#. => #",
            ".#.## => #",
            ".##.. => #",
            ".#### => #",
            "#.#.# => #",
            "#.### => #",
            "##.#. => #",
            "##.## => #",
            "###.. => #",
            "###.# => #",
            "####. => #"
        ])
        XCTAssertEqual(result, 325)
    }

    func testPart1Puzzle() throws {
        let day = Day12()
        let file = try Input(named: "Day12")
        let result = day.part1(input: file)
        XCTAssertEqual(result, 3725)
    }

    func testPart2Puzzle() throws {
        let day = Day12()
        let file = try Input(named: "Day12")
        let result = day.part2(input: file)
        XCTAssertEqual(result, 3100000000293)
    }
}
