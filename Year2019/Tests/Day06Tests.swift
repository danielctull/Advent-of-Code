
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
        let file = try Input(named: "Day06")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 278744)
    }
}
