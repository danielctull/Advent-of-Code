
import Advent
import Year2015
import XCTest

final class Day02Tests: XCTestCase {

    func testPart1Example1() {
        let result = Day02().part1(input: "2x3x4")
        XCTAssertEqual(result, 58)
    }

    func testPart1Example2() {
        let result = Day02().part1(input: "1x1x10")
        XCTAssertEqual(result, 43)
    }

    func testPart1Puzzle() throws {
        let day = Day02()
        let input = try Bundle.module.input(named: "Day02")
        let result = day.part1(input: input)
        XCTAssertEqual(result, 1606483)
    }

    func testPart2Example1() {
        let result = Day02().part2(input: "2x3x4")
        XCTAssertEqual(result, 34)
    }

    func testPart2Example2() {
        let result = Day02().part2(input: "1x1x10")
        XCTAssertEqual(result, 14)
    }

    func testPart2Puzzle() throws {
        let day = Day02()
        let input = try Bundle.module.input(named: "Day02")
        let result = day.part2(input: input)
        XCTAssertEqual(result, 3842356)
    }
}
