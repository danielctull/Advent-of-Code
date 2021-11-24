
import Advent
import Year2020
import XCTest

final class Day22Tests: XCTestCase {

    func testPart1Example() throws {
        XCTAssertEqual(try Day22.part1([
            "Player 1:",
            "9",
            "2",
            "6",
            "3",
            "1",
            "",
            "Player 2:",
            "5",
            "8",
            "4",
            "7",
            "10"]), 306)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day22")
        XCTAssertEqual(try Day22.part1(input), 32448)
    }

    func testPart2Example() throws {
        XCTAssertEqual(try Day22.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day22")
        XCTAssertEqual(try Day22.part2(input), 0)
    }
}
