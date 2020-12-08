
import Advent
import Year2020
import XCTest

final class Day08Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day08.part1([
            "nop +0",
            "acc +1",
            "jmp +4",
            "acc +3",
            "jmp -3",
            "acc -99",
            "acc +1",
            "jmp -4",
            "acc +6"
        ]), 5)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day08")
        XCTAssertEqual(try Day08.part1(input), 1501)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day08.part2([
            "nop +0",
            "acc +1",
            "jmp +4",
            "acc +3",
            "jmp -3",
            "acc -99",
            "acc +1",
            "jmp -4",
            "acc +6"
        ]), 8)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day08")
        XCTAssertEqual(try Day08.part2(input), 509)
    }
}
