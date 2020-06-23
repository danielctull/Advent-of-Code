
import Advent
import Year2018
import XCTest

final class Day09Tests: XCTestCase {

    func testPart1Example1() {
        let result = Day09().part1(input: "9 players; last marble is worth 25 points")
        XCTAssertEqual(result, 32)
    }

    func testPart1Example2() {
        let result = Day09().part1(input: "10 players; last marble is worth 1618 points")
        XCTAssertEqual(result, 8317)
    }

    func testPart1Example3() {
        let result = Day09().part1(input: "13 players; last marble is worth 7999 points")
        XCTAssertEqual(result, 146373)
    }

    func testPart1Example4() {
        let result = Day09().part1(input: "17 players; last marble is worth 1104 points")
        XCTAssertEqual(result, 2764)
    }

    func testPart1Example5() {
        let result = Day09().part1(input: "21 players; last marble is worth 6111 points")
        XCTAssertEqual(result, 54718)
    }

    func testPart1Example6() {
        let result = Day09().part1(input: "30 players; last marble is worth 5807 points")
        XCTAssertEqual(result, 37305)
    }

    func testPart1Puzzle() throws {
        let day = Day09()
        let input = try Bundle.module.input(named: "Day09")
        let result = day.part1(input: input)
        XCTAssertEqual(result, 429287)
    }

    func testPart2Puzzle() throws {
        let day = Day09()
        let input = try Bundle.module.input(named: "Day09")
        let result = day.part2(input: input)
        XCTAssertEqual(result, 3624387659)
    }
}
