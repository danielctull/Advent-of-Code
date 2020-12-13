
import Advent
import Year2020
import XCTest

final class Day13Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(try Day13.part1(["939","7,13,x,x,59,x,31,19"]), 295)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day13")
        XCTAssertEqual(try Day13.part1(input), 2845)
    }

    func testPart2Example1() throws {
        XCTAssertEqual(try Day13.part2(["UNUSED","7,13,x,x,59,x,31,19"]), 1068781)
    }

    func testPart2Example2() throws {
        XCTAssertEqual(try Day13.part2(["UNUSED","67,7,59,61"]), 754018)
    }

    func testPart2Example3() throws {
        XCTAssertEqual(try Day13.part2(["UNUSED","67,x,7,59,61"]), 779210)
    }

    func testPart2Example4() throws {
        XCTAssertEqual(try Day13.part2(["UNUSED","67,7,x,59,61"]), 1261476)
    }
    
    func testPart2Example5() throws {
        XCTAssertEqual(try Day13.part2(["UNUSED","1789,37,47,1889"]), 1202161486)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day13")
        XCTAssertEqual(try Day13.part2(input), 487905974205117)
    }
}
