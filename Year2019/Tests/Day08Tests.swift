
import Advent
import Year2019
import XCTest

final class Day08Tests: XCTestCase {

    func testPart1Example1() throws {
        let result = Day08().part1(width: 3, height: 2, input: "123456789012")
        XCTAssertEqual(result, 1)
    }

    func testPart1Puzzle() throws {
        let day = Day08()
        let file = try Input(named: "Day08")
        let result = day.part1(width: 25, height: 6, input: file)
        XCTAssertEqual(result, 2375)
    }

    func testPart2Example1() throws {
        let result = Day08().part2(width: 2, height: 2, input: "0222112222120000")
        XCTAssertEqual(result, [
            "◼️◻️",
            "◻️◼️"
        ])
    }

    func testPart2Puzzle() throws {
        let day = Day08()
        let file = try Input(named: "Day08")
        let result = day.part2(width: 25, height: 6, input: file)
        XCTAssertEqual(result, [
            "◻️◻️◻️◼️◼️◻️◼️◼️◻️◼️◻️◼️◼️◻️◼️◻️◻️◻️◼️◼️◻️◼️◼️◼️◻️",
            "◻️◼️◼️◻️◼️◻️◼️◻️◼️◼️◻️◼️◼️◻️◼️◻️◼️◼️◻️◼️◻️◼️◼️◼️◻️",
            "◻️◼️◼️◻️◼️◻️◻️◼️◼️◼️◻️◻️◻️◻️◼️◻️◼️◼️◻️◼️◼️◻️◼️◻️◼️",
            "◻️◻️◻️◼️◼️◻️◼️◻️◼️◼️◻️◼️◼️◻️◼️◻️◻️◻️◼️◼️◼️◼️◻️◼️◼️",
            "◻️◼️◻️◼️◼️◻️◼️◻️◼️◼️◻️◼️◼️◻️◼️◻️◼️◻️◼️◼️◼️◼️◻️◼️◼️",
            "◻️◼️◼️◻️◼️◻️◼️◼️◻️◼️◻️◼️◼️◻️◼️◻️◼️◼️◻️◼️◼️◼️◻️◼️◼️"
        ])
    }
}
