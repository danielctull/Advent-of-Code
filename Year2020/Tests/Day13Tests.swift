
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

    // 7, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105

    // 13, 26, 39, 52, 65, 78, 91, 104
    // 14, 27, 40, 53, 66, 79, 92, 105

    // 59, 118, 177, 236, 295, 354, 413, 472
    // 63, 122,

    // For the following sequence:
    // 7, 13, x, x, 59, x, 31, 19
    //
    //      14   105    196    287    378    469    560
    //  7:   2    15     28     41     54     67     80   > +13
    // 13: 1r1   8r1   15r1   22r1   29r1   36r1   43r1   > + 7
    //
    //      63   476    889   1302   1715
    //  7:   9    68    127    186    245                 > +59
    // 59: 1r4   8r4   15r4   22r4   29r4   36r4   43r4   > + 7



    // 7, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 112, 119, 126, 133, 140, 147, 154, 161, 168, 175

    // 13, 26, 39, 52, 65, 78, 91, 104, 117, 130, 143, 156, 169, 182
    // 12, 25, 38, 51, 64, 77, 90, 103, 116, 129, 142, 155, 168, 181

    // For the following sequence:
    // 7, 13, x, x, 59, x, 31, 19
    //
    //       77    168
    //  7:   11     24       > +13
    // 13: 5r12   8r12       > + 7
    //
    //      63   476    889   1302   1715
    //  7:   9    68    127    186    245                 > +59
    // 59: 1r4   8r4   15r4   22r4   29r4   36r4   43r4   > + 7


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
        XCTAssertEqual(try Day13.part2(input), 0)
    }
}
