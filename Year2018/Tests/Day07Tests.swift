
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
        let file = try Input(named: "Day07")
        let result = Day07().part1(input: file)
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
        ])
        XCTAssertEqual(result, 0)
    }

    func testPart2Puzzle() throws {
        let file = try Input(named: "Day07")
        let result = Day07().part2(input: file)
        XCTAssertEqual(result, 0)
    }
}
