
import Advent
import Year2018
import XCTest

final class Day02Tests: XCTestCase {

    func testPart1Example() {
        let result = Day02().part1(input: [
            "abcdef",
            "bababc",
            "abbcde",
            "abcccd",
            "aabcdd",
            "abcdee",
            "ababab"
        ])
        XCTAssertEqual(result, 12)
    }

    func testPart1Puzzle() throws {
        let day = Day02()
        let input = try Bundle.module.input(named: "Day02")
        let result = day.part1(input: input)
        XCTAssertEqual(result, 5390)
    }

    func testPart2Example() {
        let result = Day02().part2(input: [
            "abcde",
            "fghij",
            "klmno",
            "pqrst",
            "fguij",
            "axcye",
            "wvxyz"
        ])
        XCTAssertEqual(result, "fgij")
    }

    func testPart2Puzzle() throws {
        let day = Day02()
        let input = try Bundle.module.input(named: "Day02")
        let result = day.part2(input: input)
        XCTAssertEqual(result, "nvosmkcdtdbfhyxsphzgraljq")
    }
}
