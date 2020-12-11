
import Advent
import XCTest

final class PositionTests: XCTestCase {

    func testAdjacent() {
        XCTAssert(Position(x: 3, y: 6).adjacent.elementsEqual([
            Position(x: 3, y: 7),
            Position(x: 3, y: 5),
            Position(x: 2, y: 6),
            Position(x: 4, y: 6)
        ]))
    }

    func testDiagonallyAdjacent() {
        XCTAssert(Position(x: 3, y: 6).diagonallyAdjacent.elementsEqual([
            Position(x: 4, y: 7),
            Position(x: 4, y: 5),
            Position(x: 2, y: 5),
            Position(x: 2, y: 7)
        ]))
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
