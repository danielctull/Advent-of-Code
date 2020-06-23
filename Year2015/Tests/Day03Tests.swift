
import Advent
import Year2015
import XCTest

final class Day03Tests: XCTestCase {

    func testPart1Example1() {
        let result = Day03().part1(input: ">")
        XCTAssertEqual(result, 2)
    }

    func testPart1Example2() {
        let result = Day03().part1(input: "^>v<")
        XCTAssertEqual(result, 4)
    }

    func testPart1Example3() {
        let result = Day03().part1(input: "^v^v^v^v^v")
        XCTAssertEqual(result, 2)
    }

    func testPart1Puzzle() throws {
        let day = Day03()
        let input = try Bundle.module.input(named: "Day03")
        let result = day.part1(input: input)
        XCTAssertEqual(result, 2592)
    }

    func testPart2Example1() {
        let result = Day03().part2(input: "^v")
        XCTAssertEqual(result, 3)
    }

    func testPart2Example2() {
        let result = Day03().part2(input: "^>v<")
        XCTAssertEqual(result, 3)
    }

    func testPart2Example3() {
        let result = Day03().part2(input: "^v^v^v^v^v")
        XCTAssertEqual(result, 11)
    }

    func testPart2Puzzle() throws {
        let day = Day03()
        let input = try Bundle.module.input(named: "Day03")
        let result = day.part2(input: input)
        XCTAssertEqual(result, 2360)
    }
}
