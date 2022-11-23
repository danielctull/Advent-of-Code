
import Advent
import Year2016
import XCTest

final class Day01Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day01.part1(["R2, L3"]), 5)
        XCTAssertEqual(try Day01.part1(["R2, R2, R2"]), 2)
        XCTAssertEqual(try Day01.part1(["R5, L5, R5, R3"]), 12)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(try Day01.part1(input), 234)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day01.part2(["R8, R4, R4, R8"]), 4)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(try Day01.part2(input), 113)
    }
}
