
import Advent
import Year2019
import XCTest

final class Day24Tests: XCTestCase {

    func testPart1Example1() throws {
        let result = try Day24().part1(input: [
            "....#",
            "#..#.",
            "#..##",
            "..#..",
            "#...."
        ])
        XCTAssertEqual(result, 2129920)
    }

    func testPart1Puzzle() throws {
        let day = Day24()
        let file = try Input(named: "Day24")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 18842609)
    }

    func testLocationAdjacency1() {
        let adjacent = Day24.Location(level: 0, position: Position(x: 3, y: 3)).adjacent
        XCTAssertEqual(adjacent.count, 4)
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 2, y: 3))))
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 4, y: 3))))
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 3, y: 2))))
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 3, y: 4))))
    }

    func testLocationAdjacency2() {
        let adjacent = Day24.Location(level: 1, position: Position(x: 1, y: 1)).adjacent
        XCTAssertEqual(adjacent.count, 4)
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 1, y: 0))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 0, y: 1))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 2, y: 1))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 1, y: 2))))
    }

    func testLocationAdjacency3() {
        let adjacent = Day24.Location(level: 1, position: Position(x: 3, y: 0)).adjacent
        XCTAssertEqual(adjacent.count, 4)
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 2, y: 1))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 2, y: 0))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 4, y: 0))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 3, y: 1))))
    }

    func testLocationAdjacency4() {
        let adjacent = Day24.Location(level: 1, position: Position(x: 4, y: 0)).adjacent
        XCTAssertEqual(adjacent.count, 4)
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 2, y: 1))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 3, y: 0))))
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 3, y: 2))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 4, y: 1))))
    }

    func testLocationAdjacency5() {
        let adjacent = Day24.Location(level: 0, position: Position(x: 3, y: 2)).adjacent
        XCTAssertEqual(adjacent.count, 8)
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 3, y: 1))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 4, y: 0))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 4, y: 1))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 4, y: 2))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 4, y: 3))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 4, y: 4))))
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 4, y: 2))))
        XCTAssert(adjacent.contains(Day24.Location(level: 0, position: Position(x: 3, y: 3))))
    }

    func testLocationAdjacency6() {
        let adjacent = Day24.Location(level: 1, position: Position(x: 3, y: 2)).adjacent
        XCTAssertEqual(adjacent.count, 8)
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 3, y: 1))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 4, y: 2))))
        XCTAssert(adjacent.contains(Day24.Location(level: 1, position: Position(x: 3, y: 3))))
        XCTAssert(adjacent.contains(Day24.Location(level: 2, position: Position(x: 4, y: 0))))
        XCTAssert(adjacent.contains(Day24.Location(level: 2, position: Position(x: 4, y: 1))))
        XCTAssert(adjacent.contains(Day24.Location(level: 2, position: Position(x: 4, y: 2))))
        XCTAssert(adjacent.contains(Day24.Location(level: 2, position: Position(x: 4, y: 3))))
        XCTAssert(adjacent.contains(Day24.Location(level: 2, position: Position(x: 4, y: 4))))
    }

    func testPart2Example1() throws {
        let result = try Day24().part2(input: [
            "....#",
            "#..#.",
            "#..##",
            "..#..",
            "#...."
        ], count: 10)
        XCTAssertEqual(result, 99)
    }

    func testPart2Puzzle() throws {
        let day = Day24()
        let file = try Input(named: "Day24")
        let result = try day.part2(input: file)
        XCTAssertEqual(result, 2059)
    }
}
