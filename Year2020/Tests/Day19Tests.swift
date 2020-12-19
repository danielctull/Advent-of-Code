
import Advent
import Year2020
import XCTest

final class Day19Tests: XCTestCase {

    func testPart1Example() throws {
        XCTAssertEqual(try Day19.part1([
            #"0: 4 1 5"#,
            #"1: 2 3 | 3 2"#,
            #"2: 4 4 | 5 5"#,
            #"3: 4 5 | 5 4"#,
            #"4: "a""#,
            #"5: "b""#,
            #""#,
            #"ababbb"#,
            #"bababa"#,
            #"abbbab"#,
            #"aaabbb"#,
            #"aaaabbb"#
        ]), 2)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day19")
        XCTAssertEqual(try Day19.part1(input), 165)
    }


    func testPart2Example() throws {
        XCTAssertEqual(try Day19.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day19")
        XCTAssertEqual(try Day19.part2(input), 0)
    }
}
