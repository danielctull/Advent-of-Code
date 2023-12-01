
import Advent
import Year2023
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day01.part1([
            "1abc2",
            "pqr3stu8vwx",
            "a1b2c3d4e5f",
            "treb7uchet",
        ]), 142)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(try Day01.part1(input), 54338)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day01.part2([
            "two1nine",
            "eightwothree",
            "abcone2threexyz",
            "xtwone3four",
            "4nineeightseven2",
            "zoneight234",
            "7pqrstsixteen",
        ]), 281)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(try Day01.part2(input), 53389)
    }
}
