
import Advent
import Year2019
import XCTest

final class Day09Tests: XCTestCase {
    
    func testPart1Example1() throws {
        let code = "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
        let output = try Day09().part1(input: [code])
        XCTAssertEqual(output, 99)
    }
    
    func testPart1Example2() throws {
        let code = "1102,34915192,34915192,7,4,7,99,0"
        let output = try Day09().part1(input: [code])
        XCTAssertEqual(output, 1219070632396864)
    }
    
    func testPart1Example3() throws {
        let code = "104,1125899906842624,99"
        let output = try Day09().part1(input: [code])
        XCTAssertEqual(output, 1125899906842624)
    }
    
    func testPart1Puzzle() throws {
        let day = Day09()
        let input = try Bundle.module.input(named: "Day09")
        let result = try day.part1(input: input)
        XCTAssertEqual(result, 3518157894)
    }

    func testPart2Puzzle() throws {
        let day = Day09()
        let input = try Bundle.module.input(named: "Day09")
        let result = try day.part2(input: input)
        XCTAssertEqual(result, 80379)
    }
}
