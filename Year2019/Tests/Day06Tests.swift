
import Advent
import Year2019
import XCTest

final class Day06Tests: XCTestCase {

    func testPart1Example1() throws {
        let result = try Day06().part1(input: [
            "COM)B",
            "B)C",
            "C)D",
            "D)E",
            "E)F",
            "B)G",
            "G)H",
            "D)I",
            "E)J",
            "J)K",
            "K)L",])
        XCTAssertEqual(result, 42)
    }

    func testPart1Puzzle() throws {
        let day = Day06()
        let input = try Bundle.module.input(named: "Day06")
        let result = try day.part1(input: input)
        XCTAssertEqual(result, 278744)
    }

    func testPart2Example1() throws {
        let result = try Day06().part2(input: [
            "COM)B",
            "B)C",
            "C)D",
            "D)E",
            "E)F",
            "B)G",
            "G)H",
            "D)I",
            "E)J",
            "J)K",
            "K)L",
            "K)YOU",
            "I)SAN"])
        XCTAssertEqual(result, 4)
    }

    func testPart2Puzzle() throws {
        let day = Day06()
        let input = try Bundle.module.input(named: "Day06")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 475)
    }
}
