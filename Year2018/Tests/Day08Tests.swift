
import Advent
import Year2018
import XCTest

final class Day08Tests: XCTestCase {

    func testPart1Example() {
        let result = Day08().part1(input: "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2")
        XCTAssertEqual(result, 138)
    }

    func testPart1Puzzle() throws {
        let file = try Input(named: "Day08")
        let result = Day08().part1(input: file)
        XCTAssertEqual(result, 47244)
    }

    func testPart2Example() {
        let result = Day08().part2(input: "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2")
        XCTAssertEqual(result, 66)
    }

    func testPart2Puzzle() throws {
        let file = try Input(named: "Day08")
        let result = Day08().part2(input: file)
        XCTAssertEqual(result, 17267)
    }
}
