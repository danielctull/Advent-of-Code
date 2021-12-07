
import Advent
import Year2021
import Year2019
import XCTest

final class Day07Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Year2021.Day07.part1(["16,1,2,0,4,2,7,1,2,14"]), 37)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        XCTAssertEqual(try Year2021.Day07.part1(input), 344535)
    }

    func testPart2Examples() throws {
        XCTAssertEqual(try Year2021.Day07.part2(["16,1,2,0,4,2,7,1,2,14"]), 168)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        XCTAssertEqual(try Year2021.Day07.part2(input), 95581659)
    }

    func testIntcode() throws {
        let input = try Bundle.module.input(named: "Day07")
        var computer = IntcodeComputer(input: input)
        try computer.run()
        XCTAssertEqual(computer.ascii.output, "Ceci n'est pas une intcode program\n")
    }
}
