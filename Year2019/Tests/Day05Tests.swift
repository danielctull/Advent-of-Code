
import Advent
import Year2019
import XCTest

final class Day05Tests: XCTestCase {

    func testPart1Puzzle() throws {
        let day = Day05()
        let file = try Input(named: "Day05")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 9006673)
    }

    private func run(code: [Int], input: Int) throws -> Int {
        let computer = IntcodeComputer(code: code)
        try computer.run(input)
        return computer.state.value
    }

    func testPart2Example1() throws {
        let code = [3,9,8,9,10,9,4,9,99,-1,8]
        XCTAssertEqual(try run(code: code, input: 8), 1)
        XCTAssertEqual(try run(code: code, input: 7), 0)
    }

    func testPart2Example2() throws {
        let code = [3,9,7,9,10,9,4,9,99,-1,8]
        XCTAssertEqual(try run(code: code, input: 7), 1)
        XCTAssertEqual(try run(code: code, input: 8), 0)
    }

    func testPart2Example3() throws {
        let code = [3,3,1108,-1,8,3,4,3,99]
        XCTAssertEqual(try run(code: code, input: 8), 1)
        XCTAssertEqual(try run(code: code, input: 9), 0)
    }

    func testPart2Example4() throws {
        let code = [3,3,1107,-1,8,3,4,3,99]
        XCTAssertEqual(try run(code: code, input: 7), 1)
        XCTAssertEqual(try run(code: code, input: 8), 0)
    }

    func testPart2Example5() throws {
        let code = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
        XCTAssertEqual(try run(code: code, input: 0), 0)
        XCTAssertEqual(try run(code: code, input: 8), 1)
    }

    func testPart2Example6() throws {
        let code = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
        XCTAssertEqual(try run(code: code, input: 0), 0)
        XCTAssertEqual(try run(code: code, input: 8), 1)
    }

    func testPart2Example7() throws {
        let code = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
                    1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
                    999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]
        XCTAssertEqual(try run(code: code, input: 7), 999)
        XCTAssertEqual(try run(code: code, input: 8), 1000)
        XCTAssertEqual(try run(code: code, input: 9), 1001)
    }

    func testPart2Puzzle() throws {
        let day = Day05()
        let file = try Input(named: "Day05")
        let result = try day.part2(input: file)
        XCTAssertEqual(result, 3629692)
    }
}
