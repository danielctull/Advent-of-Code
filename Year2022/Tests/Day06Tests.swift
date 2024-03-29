
import Advent
import Year2022
import XCTest

final class Day06Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day06.part1("mjqjpqmgbljsphdztnvjfqwrcgsmlb"), 7)
        XCTAssertEqual(try Day06.part1("bvwbjplbgvbhsrlpgdmjqwftvncz"), 5)
        XCTAssertEqual(try Day06.part1("nppdvjthqldpwncqszvftbrmjlhg"), 6)
        XCTAssertEqual(try Day06.part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"), 10)
        XCTAssertEqual(try Day06.part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"), 11)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(try Day06.part1(input), 1896)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day06.part2("mjqjpqmgbljsphdztnvjfqwrcgsmlb"), 19)
        XCTAssertEqual(try Day06.part2("bvwbjplbgvbhsrlpgdmjqwftvncz"), 23)
        XCTAssertEqual(try Day06.part2("nppdvjthqldpwncqszvftbrmjlhg"), 23)
        XCTAssertEqual(try Day06.part2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"), 29)
        XCTAssertEqual(try Day06.part2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"), 26)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day06")
        XCTAssertEqual(try Day06.part2(input), 3452)
    }
}
