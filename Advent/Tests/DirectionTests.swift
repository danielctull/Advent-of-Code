
import Advent
import XCTest

final class DirectionTests: XCTestCase {

    func testInitPosition() {
        XCTAssertEqual(Direction(start: .origin, end: Position(x: 0, y: 1)), .up)
        XCTAssertEqual(Direction(start: .origin, end: Position(x: 0, y: -1)), .down)
        XCTAssertEqual(Direction(start: .origin, end: Position(x: 1, y: 0)), .right)
        XCTAssertEqual(Direction(start: .origin, end: Position(x: -1, y: 0)), .left)
        XCTAssertNil(Direction(start: .origin, end: Position(x: 1, y: 1)))
        XCTAssertNil(Direction(start: .origin, end: Position(x: 1, y: -1)))
        XCTAssertNil(Direction(start: .origin, end: Position(x: -1, y: -1)))
        XCTAssertNil(Direction(start: .origin, end: Position(x: -1, y: 1)))
    }

    func testOpposite() {
        XCTAssertEqual(Direction.up.opposite, .down)
        XCTAssertEqual(Direction.down.opposite, .up)
        XCTAssertEqual(Direction.left.opposite, .right)
        XCTAssertEqual(Direction.right.opposite, .left)
    }

    func testOtherDirections() {
        XCTAssertEqual(Direction.up.otherDirections, [.down, .left, .right])
        XCTAssertEqual(Direction.down.otherDirections, [.up, .left, .right])
        XCTAssertEqual(Direction.left.otherDirections, [.up, .down, .right])
        XCTAssertEqual(Direction.right.otherDirections, [.up, .down, .left])
    }

    func testRotate() {
        XCTAssertEqual(Direction.up.rotate(.left), .left)
        XCTAssertEqual(Direction.left.rotate(.left), .down)
        XCTAssertEqual(Direction.down.rotate(.left), .right)
        XCTAssertEqual(Direction.right.rotate(.left), .up)
        XCTAssertEqual(Direction.up.rotate(.right), .right)
        XCTAssertEqual(Direction.left.rotate(.right), .up)
        XCTAssertEqual(Direction.down.rotate(.right), .left)
        XCTAssertEqual(Direction.right.rotate(.right), .down)
    }
}
