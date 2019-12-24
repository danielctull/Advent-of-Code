
import Advent
import Year2019
import XCTest

final class Day24Tests: XCTestCase {

    func testPart1Example1() throws {
        let result = try Day24().part1(input: [
            "....#",
            "#..#.",
            "#..##",
            "..#..",
            "#...."
        ])
        XCTAssertEqual(result, 2129920)
    }

    func testPart1Puzzle() throws {
        let day = Day24()
        let file = try Input(named: "Day24")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 18842609)
    }
}
