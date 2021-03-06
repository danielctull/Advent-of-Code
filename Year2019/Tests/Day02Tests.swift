
import Advent
import Year2019
import XCTest

final class Day02Tests: XCTestCase {

    func testPart1Example1() throws {
        let result = try Day02().part1(input: ["1,0,0,0,99"])
        XCTAssertEqual(result, [2,0,0,0,99])
    }

    func testPart1Example2() throws {
        let result = try Day02().part1(input: ["2,3,0,3,99"])
        XCTAssertEqual(result, [2,3,0,6,99])
    }

    func testPart1Example3() throws {
        let result = try Day02().part1(input: ["2,4,4,5,99,0"])
        XCTAssertEqual(result, [2,4,4,5,99,9801])
    }

    func testPart1Example4() throws {
        let result = try Day02().part1(input: ["1,1,1,4,99,5,6,0,99"])
        XCTAssertEqual(result, [30,1,1,4,2,5,6,0,99])
    }

    func testPart1Puzzle() throws {
        let day = Day02()
        let input = try Bundle.module.input(named: "Day02")
        let result = try day.part1(input: input)
        XCTAssertEqual(result[0], 8017076)
    }

    func testPart2Puzzle() throws {
        let day = Day02()
        let input = try Bundle.module.input(named: "Day02")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 3146)
    }
}
