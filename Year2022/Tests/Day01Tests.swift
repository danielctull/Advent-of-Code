
import Advent
import Year2022
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day01.part1([
            "1000",
            "2000",
            "3000",
            "",
            "4000",
            "",
            "5000",
            "6000",
            "",
            "7000",
            "8000",
            "9000",
            "",
            "10000",
        ]), 24000)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(try Day01.part1(input), 69528)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day01.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(try Day01.part2(input), 0)
    }
}
