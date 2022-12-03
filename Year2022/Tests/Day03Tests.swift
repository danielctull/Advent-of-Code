
import Advent
import Year2022
import XCTest

final class Day03Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day03.part1([
            "vJrwpWtwJgWrhcsFMMfFFhFp",
            "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
            "PmmdzqPrVvPwwTWBwg",
            "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
            "ttgJtRGJQctTZtZT",
            "CrZsJsPPZsGzwwsLwLmpwMDw",
        ]), 157)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        XCTAssertEqual(try Day03.part1(input), 8243)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day03.part2([
            "vJrwpWtwJgWrhcsFMMfFFhFp",
            "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
            "PmmdzqPrVvPwwTWBwg",
            "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
            "ttgJtRGJQctTZtZT",
            "CrZsJsPPZsGzwwsLwLmpwMDw",
        ]), 70)    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        XCTAssertEqual(try Day03.part2(input), 2631)
    }
}
