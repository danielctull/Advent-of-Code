
import Advent
import Year2024
import XCTest

final class Day05Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day05.part1([
            "47|53",
            "97|13",
            "97|61",
            "97|47",
            "75|29",
            "61|13",
            "75|53",
            "29|13",
            "97|29",
            "53|29",
            "61|53",
            "97|53",
            "61|29",
            "47|13",
            "75|47",
            "97|75",
            "47|61",
            "75|61",
            "47|29",
            "75|13",
            "53|13",
            "",
            "75,47,61,53,29",
            "97,61,53,29,13",
            "75,29,13",
            "75,97,47,61,53",
            "61,13,29",
            "97,13,75,29,47",
        ]), 143)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        XCTAssertEqual(try Day05.part1(input), 5091)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day05.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        XCTAssertEqual(try Day05.part2(input), 0)
    }
}
