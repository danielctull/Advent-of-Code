
import Advent
import Year2019
import XCTest

final class Day10Tests: XCTestCase {

    func testLineContains() {
        let p1 = Position2D(x: 0, y: 0)
        let p2 = Position2D(x: 1, y: 1)
        let p3 = Position2D(x: 4, y: 4)
        let line = Day10.Line(start: p1, end: p3)
        XCTAssertTrue(line.contains(p2))
    }

    func testLineDoesntContain() {
        let p1 = Position2D(x: 0, y: 0)
        let p2 = Position2D(x: 1, y: 1)
        let p3 = Position2D(x: 5, y: 4)
        let line = Day10.Line(start: p1, end: p3)
        XCTAssertFalse(line.contains(p2))
    }

    func testPart1Example1() throws {
        let output = try Day10().part1(input: [
            ".#..#",
            ".....",
            "#####",
            "....#",
            "...##"])
        XCTAssertEqual(output.0.x, 3)
        XCTAssertEqual(output.0.y, 4)
        XCTAssertEqual(output.1, 8)
    }

    func testPart1Example2() throws {
        let output = try Day10().part1(input: [
            "......#.#.",
            "#..#.#....",
            "..#######.",
            ".#.#.###..",
            ".#..#.....",
            "..#....#.#",
            "#..#....#.",
            ".##.#..###",
            "##...#..#.",
            ".#....####"])
        XCTAssertEqual(output.0.x, 5)
        XCTAssertEqual(output.0.y, 8)
        XCTAssertEqual(output.1, 33)
    }

    func testPart1Example3() throws {
        let output = try Day10().part1(input: [
            "#.#...#.#.",
            ".###....#.",
            ".#....#...",
            "##.#.#.#.#",
            "....#.#.#.",
            ".##..###.#",
            "..#...##..",
            "..##....##",
            "......#...",
            ".####.###."])
        XCTAssertEqual(output.0.x, 1)
        XCTAssertEqual(output.0.y, 2)
        XCTAssertEqual(output.1, 35)
    }

    func testPart1Example4() throws {
        let output = try Day10().part1(input: [
            ".#..#..###",
            "####.###.#",
            "....###.#.",
            "..###.##.#",
            "##.##.#.#.",
            "....###..#",
            "..#.#..#.#",
            "#..#.#.###",
            ".##...##.#",
            ".....#.#.."])
        XCTAssertEqual(output.0.x, 6)
        XCTAssertEqual(output.0.y, 3)
        XCTAssertEqual(output.1, 41)
    }

    func testPart1Example5() throws {
        let output = try Day10().part1(input: [
            ".#..##.###...#######",
            "##.############..##.",
            ".#.######.########.#",
            ".###.#######.####.#.",
            "#####.##.#.##.###.##",
            "..#####..#.#########",
            "####################",
            "#.####....###.#.#.##",
            "##.#################",
            "#####.##.###..####..",
            "..######..##.#######",
            "####.##.####...##..#",
            ".#####..#.######.###",
            "##...#.##########...",
            "#.##########.#######",
            ".####.#.###.###.#.##",
            "....##.##.###..#####",
            ".#.#.###########.###",
            "#.#.#.#####.####.###",
            "###.##.####.##.#..##"])
        XCTAssertEqual(output.0.x, 11)
        XCTAssertEqual(output.0.y, 13)
        XCTAssertEqual(output.1, 210)
    }

    func testPart1Puzzle() throws {
        let day = Day10()
        let input = try Bundle.module.input(named: "Day10")
        let result = try day.part1(input: input)
        XCTAssertEqual(result.1, 274)
    }

    func testPart2Example1() throws {
        let output = try Day10().part2(input: [
            ".#..##.###...#######",
            "##.############..##.",
            ".#.######.########.#",
            ".###.#######.####.#.",
            "#####.##.#.##.###.##",
            "..#####..#.#########",
            "####################",
            "#.####....###.#.#.##",
            "##.#################",
            "#####.##.###..####..",
            "..######..##.#######",
            "####.##.####...##..#",
            ".#####..#.######.###",
            "##...#.##########...",
            "#.##########.#######",
            ".####.#.###.###.#.##",
            "....##.##.###..#####",
            ".#.#.###########.###",
            "#.#.#.#####.####.###",
            "###.##.####.##.#..##"])
        XCTAssertEqual(output, 802)
    }

    func testPart2Puzzle() throws {
        let day = Day10()
        let input = try Bundle.module.input(named: "Day10")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 305)
    }
}
