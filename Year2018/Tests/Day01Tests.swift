
import Advent
import Year2018
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Example1() {
        let result = Day01().part1(input: "+1, +1, +1")
        XCTAssertEqual(result, 3)
    }

    func testPart1Example2() {
        let result = Day01().part1(input: "+1, +1, -2")
        XCTAssertEqual(result, 0)
    }

    func testPart1Example3() {
        let result = Day01().part1(input: "-1, -2, -3")
        XCTAssertEqual(result, -6)
    }

    func testPart1Puzzle() throws {
        let day = Day01()
        let input = try Bundle.module.input(named: "Day01")
        let result = day.part1(input: input)
        XCTAssertEqual(result, 425)
    }

    func testPart2Example1() {
        let result = Day01().part2(input: "+1, -1")
        XCTAssertEqual(result, 0)
    }

    func testPart2Example2() {
        let result = Day01().part2(input: "+3, +3, +4, -2, -4")
        XCTAssertEqual(result, 10)
    }

    func testPart2Example3() {
        let result = Day01().part2(input: "-6, +3, +8, +5, -6")
        XCTAssertEqual(result, 5)
    }

    func testPart2Example4() {
        let result = Day01().part2(input: "+7, +7, -2, -7, -4")
        XCTAssertEqual(result, 14)
    }

    func testPart2Puzzle() throws {
        let day = Day01()
        let input = try Bundle.module.input(named: "Day01")
        let result = day.part2(input: input)
        XCTAssertEqual(result, 57538)
    }
}
