
import Advent
import Year2023
import XCTest

final class Day07Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day07.part1([
            "32T3K 765",
            "T55J5 684",
            "KK677 28",
            "KTJJT 220",
            "QQQJA 483",
        ]), 6440)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        XCTAssertEqual(try Day07.part1(input), 248559379)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day07.part2([
            "32T3K 765",
            "T55J5 684",
            "KK677 28",
            "KTJJT 220",
            "QQQJA 483",
        ]), 5905)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        XCTAssertEqual(try Day07.part2(input), 249631254)
    }
}
