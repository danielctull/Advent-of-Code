
import Advent
import YearYYYY
import XCTest

final class DayDDTests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try DayDD.part1([]), 0)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "DayDD")
        XCTAssertEqual(try DayDD.part1(input), 0)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try DayDD.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "DayDD")
        XCTAssertEqual(try DayDD.part2(input), 0)
    }
}
