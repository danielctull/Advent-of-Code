
import Advent
import XCTest

final class PositionTests: XCTestCase {

    func testAdjacent() {
        XCTAssertEqual(Position.origin.adjacent, [
            Position(x: 0, y: 1),
            Position(x: 0, y: -1),
            Position(x: -1, y: 0),
            Position(x: 1, y: 0)
        ])
    }

    func testManhattenDistance() {
        XCTAssertEqual(
            Position.origin.manhattenDistance(to: Position(x: 3, y: 2)),
            5
        )
        XCTAssertEqual(
            Position(x: 5, y: 1).manhattenDistance(to: Position(x: 3, y: 2)),
            3
        )
    }

    func testOffsetting() {
        XCTAssertEqual(
            Position.origin.offsetting(x: 2, y: 3),
            Position(x: 2, y: 3)
        )
        XCTAssertEqual(
            Position(x: 1, y: 6).offsetting(x: -3, y: 3),
            Position(x: -2, y: 9)
        )
    }
}
