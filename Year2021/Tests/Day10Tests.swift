
import Advent
import Year2021
import XCTest

final class Day10Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day10.part1([
            "[({(<(())[]>[[{[]{<()<>>",
            "[(()[<>])]({[<{<<[]>>(",
            "{([(<{}[<>[]}>{[]{[(<()>",
            "(((({<>}<{<{<>}{[]{[]{}",
            "[[<[([]))<([[{}[[()]]]",
            "[{[{({}]{}}([{[{{{}}([]",
            "{<[[]]>}<{[{[{[]{()[[[]",
            "[<(<(<(<{}))><([]([]()",
            "<{([([[(<>()){}]>(<<{{",
            "<{([{{}}[<[[[<>{}]]]>[]]",
        ]), 26397)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day10")
        XCTAssertEqual(try Day10.part1(input), 296535)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Day10.part2([]), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day10")
        XCTAssertEqual(try Day10.part2(input), 0)
    }
}
