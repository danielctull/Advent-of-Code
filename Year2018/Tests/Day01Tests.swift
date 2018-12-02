
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
        let file = try Input(named: "Day01")
        let result = day.part1(input: file)
        XCTAssertEqual(result, 425)
    }
}
