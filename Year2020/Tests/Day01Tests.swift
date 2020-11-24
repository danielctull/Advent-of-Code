
import Advent
import Year2020
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(Day01.part1("1"), 0)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(Day01.part1(input), 0)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(Day01.part2("1"), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(Day01.part2(input), 0)
    }
}
