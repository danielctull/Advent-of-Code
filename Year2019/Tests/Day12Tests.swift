
import Advent
import Year2019
import XCTest

final class Day12Tests: XCTestCase {

    func testPart1Example1() throws {
        let output = try Day12().part1(steps: 10, input: [
            "<x=-1, y=0, z=2>",
            "<x=2, y=-10, z=-7>",
            "<x=4, y=-8, z=8>",
            "<x=3, y=5, z=-1>"
        ])
        XCTAssertEqual(output, 179)
    }

    func testPart1Example2() throws {
        let output = try Day12().part1(steps: 100, input: [
            "<x=-8, y=-10, z=0>",
            "<x=5, y=5, z=10>",
            "<x=2, y=-7, z=3>",
            "<x=9, y=-8, z=-3>"
        ])
        XCTAssertEqual(output, 1940)
    }

    func testPart1Puzzle() throws {
        let day = Day12()
        let input = try Bundle.module.input(named: "Day12")
        let result = try day.part1(steps: 1000, input: input)
        XCTAssertEqual(result, 10189)
    }

    func testPart2Example1() throws {
        let output = try Day12().part2(input: [
            "<x=-1, y=0, z=2>",
            "<x=2, y=-10, z=-7>",
            "<x=4, y=-8, z=8>",
            "<x=3, y=5, z=-1>"
        ])
        XCTAssertEqual(output, 2772)
    }

    func testPart2Example2() throws {
        let output = try Day12().part2(input: [
            "<x=-8, y=-10, z=0>",
            "<x=5, y=5, z=10>",
            "<x=2, y=-7, z=3>",
            "<x=9, y=-8, z=-3>"
        ])
        XCTAssertEqual(output, 4686774924)
    }

    func testPart2Puzzle() throws {
        let day = Day12()
        let input = try Bundle.module.input(named: "Day12")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 469671086427712)
    }
}
