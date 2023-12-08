
import Advent
import Year2023
import XCTest

final class Day08Tests: XCTestCase {

    func testPart1Example1() throws {
        XCTAssertEqual(try Day08.part1([
            "RL",
            "",
            "AAA = (BBB, CCC)",
            "BBB = (DDD, EEE)",
            "CCC = (ZZZ, GGG)",
            "DDD = (DDD, DDD)",
            "EEE = (EEE, EEE)",
            "GGG = (GGG, GGG)",
            "ZZZ = (ZZZ, ZZZ)",
        ]), 2)
    }

    func testPart1Example2() throws {
        XCTAssertEqual(try Day08.part1([
            "LLR",
            "",
            "AAA = (BBB, BBB)",
            "BBB = (AAA, ZZZ)",
            "ZZZ = (ZZZ, ZZZ)",
        ]), 6)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day08")
        XCTAssertEqual(try Day08.part1(input), 16343)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day08.part2([
            "LR",
            "",
            "11A = (11B, XXX)",
            "11B = (XXX, 11Z)",
            "11Z = (11B, XXX)",
            "22A = (22B, XXX)",
            "22B = (22C, 22C)",
            "22C = (22Z, 22Z)",
            "22Z = (22B, 22B)",
            "XXX = (XXX, XXX)",
        ]), 6)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day08")
        XCTAssertEqual(try Day08.part2(input), 15299095336639)
    }
}
