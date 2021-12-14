
import Advent
import Year2021
import XCTest

final class Day14Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day14.part1([
            "NNCB",
            "",
            "CH -> B",
            "HH -> N",
            "CB -> H",
            "NH -> C",
            "HB -> C",
            "HC -> B",
            "HN -> C",
            "NN -> C",
            "BH -> H",
            "NC -> B",
            "NB -> B",
            "BN -> B",
            "BB -> N",
            "BC -> B",
            "CC -> N",
            "CN -> C",
        ]), 1588)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day14")
        XCTAssertEqual(try Day14.part1(input), 2360)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day14.part2([
            "NNCB",
            "",
            "CH -> B",
            "HH -> N",
            "CB -> H",
            "NH -> C",
            "HB -> C",
            "HC -> B",
            "HN -> C",
            "NN -> C",
            "BH -> H",
            "NC -> B",
            "NB -> B",
            "BN -> B",
            "BB -> N",
            "BC -> B",
            "CC -> N",
            "CN -> C",
        ]), 2188189693529)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day14")
        XCTAssertEqual(try Day14.part2(input), 2967977072188)
    }
}
