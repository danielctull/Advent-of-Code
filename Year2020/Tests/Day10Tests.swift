
import Advent
import Year2020
import XCTest

final class Day10Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day10.part1("16,10,15,5,1,11,7,19,6,12,4"), 35)
        XCTAssertEqual(try Day10.part1("28,33,18,42,31,14,46,20,48,47,24,23,49,45,19,38,39,11,1,32,25,35,8,17,7,9,4,2,34,10,3"), 220)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day10")
        XCTAssertEqual(try Day10.part1(input), 2210)
    }

    func testPart2Example1() throws {
        XCTAssertEqual(try Day10.part2("16,10,15,5,1,11,7,19,6,12,4"), 8)
    }

    func testPart2Example2() throws {
        XCTAssertEqual(try Day10.part2("28,33,18,42,31,14,46,20,48,47,24,23,49,45,19,38,39,11,1,32,25,35,8,17,7,9,4,2,34,10,3"), 19208)        }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day10")
        XCTAssertEqual(try Day10.part2(input), 7086739046912)
    }
}
