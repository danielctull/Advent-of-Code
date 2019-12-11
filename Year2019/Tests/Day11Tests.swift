
import Advent
import Year2019
import XCTest

final class Day11Tests: XCTestCase {

    func testRobot() {
        var robot = RobotPainter()
        XCTAssertEqual(robot.state(), """
            ^
            """)

        robot.paint(value: 1)
        robot.move(value: 0)
        XCTAssertEqual(robot.state(), """
            <#
            """)

        robot.paint(value: 0)
        robot.move(value: 0)
        XCTAssertEqual(robot.state(), """
            .#
            v.
            """)

        robot.paint(value: 1)
        robot.move(value: 0)
        robot.paint(value: 1)
        robot.move(value: 0)
        XCTAssertEqual(robot.state(), """
            .^
            ##
            """)

        robot.paint(value: 0)
        robot.move(value: 1)
        robot.paint(value: 1)
        robot.move(value: 0)
        robot.paint(value: 1)
        robot.move(value: 0)
        XCTAssertEqual(robot.state(), """
            .<#
            ..#
            ##.
            """)
    }

    func testPart1Puzzle() throws {
        let day = Day11()
        let file = try Input(named: "Day11")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 1967)
    }
}
