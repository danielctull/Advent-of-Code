
import Advent
import Year2024
import XCTest

final class Day03Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day03.part1([
            "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
        ]), 161)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        XCTAssertEqual(try Day03.part1(input), 179571322)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day03.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        XCTAssertEqual(try Day03.part2(input), 0)
    }
}
