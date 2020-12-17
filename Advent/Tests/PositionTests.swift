
import Advent
import XCTest

final class PositionTests: XCTestCase {

    func testAdjacent() {
        XCTAssert(Position2D(x: 3, y: 6).orthogonallyAdjacent.elementsEqual([
            Position2D(x: 3, y: 7),
            Position2D(x: 3, y: 5),
            Position2D(x: 2, y: 6),
            Position2D(x: 4, y: 6)
        ]))
    }

    func testDiagonallyAdjacent() {
        XCTAssert(Position2D(x: 3, y: 6).diagonallyAdjacent.elementsEqual([
            Position2D(x: 4, y: 7),
            Position2D(x: 4, y: 5),
            Position2D(x: 2, y: 5),
            Position2D(x: 2, y: 7)
        ]))
    }

    func testManhattenDistance() {
        XCTAssertEqual(
            Position2D.origin.manhattenDistance(to: Position2D(x: 3, y: 2)),
            5
        )
        XCTAssertEqual(
            Position2D(x: 5, y: 1).manhattenDistance(to: Position2D(x: 3, y: 2)),
            3
        )
    }

    func testMove() {
        XCTAssertEqual(
            mutating(Position2D(x: 5, y: 6)) { $0 += Vector2D(x: 4, y: 2) },
            Position2D(x: 9, y: 8)
        )
        XCTAssertEqual(
            mutating(Position2D(x: 1, y: 6)) { $0 += Vector2D(x: -3, y: 3) },
            Position2D(x: -2, y: 9)
        )
    }

    func testMoving() {
        XCTAssertEqual(
            Position2D.origin + Vector2D(x: 2, y: 3),
            Position2D(x: 2, y: 3)
        )
        XCTAssertEqual(
            Position2D(x: 1, y: 6) + Vector2D(x: -3, y: 3),
            Position2D(x: -2, y: 9)
        )
    }

    func testRotate() {
        XCTAssertEqual(
            mutating(Position2D(x: 1, y: 2)) { $0.rotate(.left) },
            Position2D(x: -2, y: 1)
        )
        XCTAssertEqual(
            mutating(Position2D(x: 2, y: 1)) { $0.rotate(.right) },
            Position2D(x: 1, y: -2)
        )
    }

    func testRotating() {
        XCTAssertEqual(
            Position2D(x: 1, y: -2).rotating(.left),
            Position2D(x: 2, y: 1)
        )
        XCTAssertEqual(
            Position2D(x: 1, y: -2).rotating(.right),
            Position2D(x: -2, y: -1)
        )
    }
}
