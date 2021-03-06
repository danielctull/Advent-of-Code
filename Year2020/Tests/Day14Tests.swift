
import Advent
import Year2020
import XCTest

final class Day14Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day14.part1([
            "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
            "mem[8] = 11",
            "mem[7] = 101",
            "mem[8] = 0"
        ]), 165)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day14")
        XCTAssertEqual(try Day14.part1(input), 14553106347726)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day14.part2([
            "mask = 000000000000000000000000000000X1001X",
            "mem[42] = 100",
            "mask = 00000000000000000000000000000000X0XX",
            "mem[26] = 1"
        ]), 208)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day14")
        XCTAssertEqual(try Day14.part2(input), 2737766154126)
    }
}
