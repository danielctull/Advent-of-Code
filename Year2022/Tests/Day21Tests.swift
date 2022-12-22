
import Advent
import Year2022
import XCTest

final class Day21Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day21.part1([
            "root: pppw + sjmn",
            "dbpl: 5",
            "cczh: sllz + lgvd",
            "zczc: 2",
            "ptdq: humn - dvpt",
            "dvpt: 3",
            "lfqf: 4",
            "humn: 5",
            "ljgn: 2",
            "sjmn: drzm * dbpl",
            "sllz: 4",
            "pppw: cczh / lfqf",
            "lgvd: ljgn * ptdq",
            "drzm: hmdt - zczc",
            "hmdt: 32",
        ]), 152)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day21")
        XCTAssertEqual(try Day21.part1(input), 81075092088442)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day21.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day21")
        XCTAssertEqual(try Day21.part2(input), 0)
    }
}
