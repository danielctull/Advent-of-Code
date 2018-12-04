
import Advent
import Year2018
import XCTest

final class Day03Tests: XCTestCase {

    func testPart1Example1() {
        let result = Day03().part1(input: [
            "#1 @ 1,3: 4x4",
            "#2 @ 3,1: 4x4",
            "#3 @ 5,5: 2x2"
        ])
        XCTAssertEqual(result, 4)
    }

    func testPart1Puzzle() throws {
        let day = Day03()
        let file = try Input(named: "Day03")
        let result = day.part1(input: file)
        XCTAssertEqual(result, 115242)
    }

    func testPart2Example1() {
        let result = Day03().part2(input: [
            "#1 @ 1,3: 4x4",
            "#2 @ 3,1: 4x4",
            "#3 @ 5,5: 2x2"
        ])
        XCTAssertEqual(result, "3")
    }

    func testPart2Puzzle() throws {
        let day = Day03()
        let file = try Input(named: "Day03")
        let result = day.part2(input: file)
        XCTAssertEqual(result, "1046")
    }
}
