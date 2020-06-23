
import Advent
import Year2019
import XCTest

final class Day22Tests: XCTestCase {

    func testPart1Example1() throws {
        let result = try Day22().shuffle(
            cards: 0...9,
            input: [
                "deal with increment 7",
                "deal into new stack",
                "deal into new stack"
            ])
        XCTAssertEqual(result, [0, 3, 6, 9, 2, 5, 8, 1, 4, 7])
    }

    func testPart1Example2() throws {
        let result = try Day22().shuffle(
            cards: 0...9,
            input: [
                "cut 6",
                "deal with increment 7",
                "deal into new stack"
            ])
        XCTAssertEqual(result, [3, 0, 7, 4, 1, 8, 5, 2, 9, 6])
    }

    func testPart1Example3() throws {
        let result = try Day22().shuffle(
            cards: 0...9,
            input: [
                "deal with increment 7",
                "deal with increment 9",
                "cut -2"
            ])
        XCTAssertEqual(result, [6, 3, 0, 7, 4, 1, 8, 5, 2, 9])
    }

    func testPart1Example4() throws {
        let result = try Day22().shuffle(
            cards: 0...9,
            input: [
                "deal into new stack",
                "cut -2",
                "deal with increment 7",
                "cut 8",
                "cut -4",
                "deal with increment 7",
                "cut 3",
                "deal with increment 9",
                "deal with increment 3",
                "cut -1"
            ])
        XCTAssertEqual(result, [9, 2, 5, 8, 1, 4, 7, 0, 3, 6])
    }

    func testPart1Puzzle() throws {
        let day = Day22()
        let input = try Bundle.module.input(named: "Day22")
        let result = try day.part1(input: input)
        XCTAssertEqual(result, 4096)
    }
}
