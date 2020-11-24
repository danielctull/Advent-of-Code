
import Advent
import Year2020
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Examples() throws {
        Assert(Day01.part1, "1", 0)
    }

    func testPart1Puzzle() throws {
        try Assert(Day01.part1, .file("Day01"), 0)
    }

    func testPart2Examples() throws {
        Assert(Day01.part2, "1", 0)
    }

    func testPart2Puzzle() throws {
        try Assert(Day01.part2, .file("Day01"), 0)
    }
}
