
import Advent
import Year2023
import XCTest

final class Day04Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day04.part1([
          "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
          "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
          "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
          "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
          "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
          "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11",
        ]), 13)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day04")
        XCTAssertEqual(try Day04.part1(input), 17782)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day04.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day04")
        XCTAssertEqual(try Day04.part2(input), 0)
    }
}
