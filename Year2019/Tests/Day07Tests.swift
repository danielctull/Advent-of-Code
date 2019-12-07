
import Advent
import Year2019
import XCTest

final class Day07Tests: XCTestCase {

    func testPart1Example1() throws {
        let code = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
        let output0 = try IntcodeComputer(code: code).run(4, 0).value
        let output1 = try IntcodeComputer(code: code).run(3, output0).value
        let output2 = try IntcodeComputer(code: code).run(2, output1).value
        let output3 = try IntcodeComputer(code: code).run(1, output2).value
        let output4 = try IntcodeComputer(code: code).run(0, output3).value
        XCTAssertEqual(output4, 43210)
    }

    func testPart1Example2() throws {
        let code = [3,23,3,24,1002,24,10,24,1002,23,-1,23,
                    101,5,23,23,1,24,23,23,4,23,99,0,0]
        let output0 = try IntcodeComputer(code: code).run(0, 0).value
        let output1 = try IntcodeComputer(code: code).run(1, output0).value
        let output2 = try IntcodeComputer(code: code).run(2, output1).value
        let output3 = try IntcodeComputer(code: code).run(3, output2).value
        let output4 = try IntcodeComputer(code: code).run(4, output3).value
        XCTAssertEqual(output4, 54321)
    }

    func testPart1Example3() throws {
        let code = [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
                    1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]
        let output0 = try IntcodeComputer(code: code).run(1, 0).value
        let output1 = try IntcodeComputer(code: code).run(0, output0).value
        let output2 = try IntcodeComputer(code: code).run(4, output1).value
        let output3 = try IntcodeComputer(code: code).run(3, output2).value
        let output4 = try IntcodeComputer(code: code).run(2, output3).value
        XCTAssertEqual(output4, 65210)
    }

    func testPart1Puzzle() throws {
        let day = Day07()
        let file = try Input(named: "Day07")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 398674)
    }
}
