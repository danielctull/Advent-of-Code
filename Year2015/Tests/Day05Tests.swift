
import Advent
import Year2015
import XCTest

final class Day05Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day05.part1("ugknbfddgicrmopn"), 1)
        XCTAssertEqual(try Day05.part1("aaa"), 1)
        XCTAssertEqual(try Day05.part1("jchzalrnumimnmhp"), 0)
        XCTAssertEqual(try Day05.part1("haegwjzuvuyypxyu"), 0)
        XCTAssertEqual(try Day05.part1("dvszwmarrgswjxmb"), 0)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        XCTAssertEqual(try Day05.part1(input), 236)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day05.part2("qjhvhtzxzqqjkmpb"), 1)
        XCTAssertEqual(try Day05.part2("xxyxx"), 1)
        XCTAssertEqual(try Day05.part2("aaaxyx"), 0)
        XCTAssertEqual(try Day05.part2("uurcxstgmygtbstg"), 0)
        XCTAssertEqual(try Day05.part2("ieodomkazucvgmuy"), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day05")
        XCTAssertEqual(try Day05.part2(input), 51)
    }
}
