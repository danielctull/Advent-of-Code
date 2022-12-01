
import Advent
import Year2019
import XCTest

final class Day03Tests: XCTestCase {

    func testPart1Example1() throws {
        XCTAssertEqual(try Day03.part1([
            "R8,U5,L5,D3",
            "U7,R6,D4,L4",
        ]), 6)
    }

    func testPart1Example2() {
        XCTAssertEqual(try Day03.part1([
            "R75,D30,R83,U83,L12,D49,R71,U7,L72",
            "U62,R66,U55,R34,D71,R55,D58,R83",
        ]), 159)
    }

    func testPart1Example3() {
        XCTAssertEqual(try Day03.part1([
            "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
            "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7",
        ]), 135)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        XCTAssertEqual(try Day03.part1(input), 489)
    }

    func testPart2Example1() {
        XCTAssertEqual(try Day03.part2([
            "R75,D30,R83,U83,L12,D49,R71,U7,L72",
            "U62,R66,U55,R34,D71,R55,D58,R83",
        ]), 610)
    }

    func testPart2Example2() {
        XCTAssertEqual(try Day03.part2([
            "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
            "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7",
        ]), 410)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day03")
        XCTAssertEqual(try Day03.part2(input), 93654)
    }
}
