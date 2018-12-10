
import Advent
import Year2015
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Example1() {
        let result = Day01().part1(input: "(())")
        XCTAssertEqual(result, 0)
    }

    func testPart1Example2() {
        let result = Day01().part1(input: "()()")
        XCTAssertEqual(result, 0)
    }

    func testPart1Example3() {
        let result = Day01().part1(input: "(((")
        XCTAssertEqual(result, 3)
    }

    func testPart1Example4() {
        let result = Day01().part1(input: "(()(()(")
        XCTAssertEqual(result, 3)
    }

    func testPart1Example5() {
        let result = Day01().part1(input: "))(")
        XCTAssertEqual(result, -1)
    }

    func testPart1Example6() {
        let result = Day01().part1(input: ")())())")
        XCTAssertEqual(result, -3)
    }

    func testPart1Puzzle() throws {
        let day = Day01()
        let file = try Input(named: "Day01")
        let result = day.part1(input: file)
        XCTAssertEqual(result, 232)
    }

    func testPart2Example1() {
        let result = Day01().part2(input: ")")
        XCTAssertEqual(result, 1)
    }

    func testPart2Example2() {
        let result = Day01().part2(input: "()())")
        XCTAssertEqual(result, 5)
    }

    func testPart2Puzzle() throws {
        let day = Day01()
        let file = try Input(named: "Day01")
        let result = day.part2(input: file)
        XCTAssertEqual(result, 1783)
    }
}
