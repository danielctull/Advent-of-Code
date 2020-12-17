
import Advent
import XCTest

final class PositionTests: XCTestCase {

    func testAdjacent() {
        XCTAssert(Position(x: 3, y: 6).orthogonallyAdjacent.elementsEqual([
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

    func testMove() {
        XCTAssertEqual(
            mutating(Position(x: 5, y: 6)) { $0 += Vector(x: 4, y: 2) },
            Position(x: 9, y: 8)
        )
        XCTAssertEqual(
            mutating(Position(x: 1, y: 6)) { $0 += Vector(x: -3, y: 3) },
            Position(x: -2, y: 9)
        )
    }

    func testMoving() {
        XCTAssertEqual(
            Position2D.origin + Vector(x: 2, y: 3),
            Position(x: 2, y: 3)
        )
        XCTAssertEqual(
            Position(x: 1, y: 6) + Vector(x: -3, y: 3),
            Position(x: -2, y: 9)
        )
    }

    func testRotate() {
        XCTAssertEqual(
            mutating(Position(x: 1, y: 2)) { $0.rotate(.left) },
            Position(x: -2, y: 1)
        )
        XCTAssertEqual(
            mutating(Position(x: 2, y: 1)) { $0.rotate(.right) },
            Position(x: 1, y: -2)
        )
    }

    func testRotating() {
        XCTAssertEqual(
            Position(x: 1, y: -2).rotating(.left),
            Position(x: 2, y: 1)
        )
        XCTAssertEqual(
            Position(x: 1, y: -2).rotating(.right),
            Position(x: -2, y: -1)
        )
    }
}
