
import Advent
import Year2019
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Example1() {
        let result = Day01().part1(input: "12")
        XCTAssertEqual(result, 2)
    }

    func testPart1Example2() {
        let result = Day01().part1(input: "14")
        XCTAssertEqual(result, 2)
    }

    func testPart1Example3() {
        let result = Day01().part1(input: "1969")
        XCTAssertEqual(result, 654)
    }

    func testPart1Example4() {
        let result = Day01().part1(input: "100756")
        XCTAssertEqual(result, 33583)
    }

    func testPart1Puzzle() throws {
        let day = Day01()
        let file = try Input(named: "Day01")
        let result = day.part1(input: file)
        XCTAssertEqual(result, 3488702)
    }
}
