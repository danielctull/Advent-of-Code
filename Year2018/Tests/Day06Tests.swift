
import Advent
import Year2018
import XCTest

final class Day06Tests: XCTestCase {

    func testPart1Example() {
        let result = Day06().part1(input: [
            "1, 1",
            "1, 6",
            "8, 3",
            "3, 4",
            "5, 5",
            "8, 9"
        ])
        XCTAssertEqual(result, 17)
    }

    func testPart1Puzzle() throws {
        let file = try Input(named: "Day06")
        let result = Day06().part1(input: file)
        XCTAssertEqual(result, 2342)
    }

    func testPart2Example() {
        let result = Day06().part2(input: "dabAcCaCBAcCcaDA")
        XCTAssertEqual(result, 0)
    }

    func testPart2Puzzle() throws {
        let file = try Input(named: "Day06")
        let result = Day06().part2(input: file)
        XCTAssertEqual(result, 0)
    }
}
