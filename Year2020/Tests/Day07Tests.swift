
import Advent
import Year2020
import XCTest

final class Day07Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day07.part1([
            "light red bags contain 1 bright white bag, 2 muted yellow bags.",
            "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
            "bright white bags contain 1 shiny gold bag.",
            "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
            "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
            "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
            "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
            "faded blue bags contain no other bags.",
            "dotted black bags contain no other bags."
        ]), 4)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        XCTAssertEqual(try Day07.part1(input), 211)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(Day07.part2(""), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        XCTAssertEqual(Day07.part2(input), 0)
    }
}
