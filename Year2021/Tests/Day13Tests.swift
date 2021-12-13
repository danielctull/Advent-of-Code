
import Advent
import Year2021
import XCTest

final class Day13Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day13.part1([
            "6,10",
            "0,14",
            "9,10",
            "0,3",
            "10,4",
            "4,11",
            "6,0",
            "6,12",
            "4,1",
            "0,13",
            "10,12",
            "3,4",
            "3,0",
            "8,4",
            "1,10",
            "2,14",
            "8,10",
            "9,0",
            "",
            "fold along y=7",
            "fold along x=5",
        ]), 17)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day13")
        XCTAssertEqual(try Day13.part1(input), 790)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day13.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day13")
        XCTAssertEqual(try Day13.part2(input), 0)
    }
}
