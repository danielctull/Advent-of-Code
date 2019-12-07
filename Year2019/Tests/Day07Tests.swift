
import Advent
import Year2019
import XCTest

final class Day07Tests: XCTestCase {

    func testPart1Example1() throws {
        let code = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
        let output = try [4,3,2,1,0].reduce(0) { result, phase in
            var computer = IntcodeComputer(code: code)
            try computer.run(phase, result)
            return computer.state.value
        }
        XCTAssertEqual(output, 43210)
    }

    func testPart1Example2() throws {
        let code = [3,23,3,24,1002,24,10,24,1002,23,-1,23,
                    101,5,23,23,1,24,23,23,4,23,99,0,0]
        let output = try [0,1,2,3,4].reduce(0) { result, phase in
            var computer = IntcodeComputer(code: code)
            try computer.run(phase, result)
            return computer.state.value
        }
        XCTAssertEqual(output, 54321)
    }

    func testPart1Example3() throws {
        let code = [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
                    1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]
        let output = try [1,0,4,3,2].reduce(0) { result, phase in
            var computer = IntcodeComputer(code: code)
            try computer.run(phase, result)
            return computer.state.value
        }
        XCTAssertEqual(output, 65210)
    }

    func testPart1Puzzle() throws {
        let day = Day07()
        let file = try Input(named: "Day07")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 398674)
    }
}
