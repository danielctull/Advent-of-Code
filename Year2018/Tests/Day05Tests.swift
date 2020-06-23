
import Advent
import Year2018
import XCTest

final class Day05Tests: XCTestCase {

    func testPart1Example() {
        let result = Day05().part1(input: "dabAcCaCBAcCcaDA")
        XCTAssertEqual(result, 10)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        let result = Day05().part1(input: input)
        XCTAssertEqual(result, 10888)
    }

    func testPart2Example() {
        let result = Day05().part2(input: "dabAcCaCBAcCcaDA")
        XCTAssertEqual(result, 4)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        let result = Day05().part2(input: input)
        XCTAssertEqual(result, 6952)
    }
}
