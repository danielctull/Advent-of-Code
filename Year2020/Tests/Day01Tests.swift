
import Advent
import Year2020
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(Day01.part1("1721,979,366,299,675,1456"), 514579)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(Day01.part1(input), 982464)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(Day01.part2("1"), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(Day01.part2(input), 0)
    }
}
