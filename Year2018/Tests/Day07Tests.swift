
import Advent
import Year2018
import XCTest

final class Day07Tests: XCTestCase {

    func testPart1Example() {
        let result = Day07().part1(input: [
            "Step C must be finished before step A can begin.",
            "Step C must be finished before step F can begin.",
            "Step A must be finished before step B can begin.",
            "Step A must be finished before step D can begin.",
            "Step B must be finished before step E can begin.",
            "Step D must be finished before step E can begin.",
            "Step F must be finished before step E can begin."
        ])
        XCTAssertEqual(result, "CABDFE")
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        let result = Day07().part1(input: input)
        XCTAssertEqual(result, "BHRTWCYSELPUVZAOIJKGMFQDXN")
    }

    func testPart2Example() {
        let result = Day07().part2(input: [
            "Step C must be finished before step A can begin.",
            "Step C must be finished before step F can begin.",
            "Step A must be finished before step B can begin.",
            "Step A must be finished before step D can begin.",
            "Step B must be finished before step E can begin.",
            "Step D must be finished before step E can begin.",
            "Step F must be finished before step E can begin."
        ], workers: 2, baseTime: 0)
        XCTAssertEqual(result, 15)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day07")
        let result = Day07().part2(input: input, workers: 5, baseTime: 60)
        XCTAssertEqual(result, 959)
    }
}
