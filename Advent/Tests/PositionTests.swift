
import Advent
import XCTest

final class PositionTests: XCTestCase {

    func testInit2D() {
        XCTAssertEqual(Position(x: 8, y: 4).x, 8)
        XCTAssertEqual(Position(x: 8, y: 4).y, 4)
    }

    func testInit3D() {
        XCTAssertEqual(Position(x: 7, y: 4, z: 3).x, 7)
        XCTAssertEqual(Position(x: 7, y: 4, z: 3).y, 4)
        XCTAssertEqual(Position(x: 7, y: 4, z: 3).z, 3)
    }

    func testInit4D() {
        XCTAssertEqual(Position(w: 6, x: 8, y: 4, z: 3).w, 6)
        XCTAssertEqual(Position(w: 6, x: 8, y: 4, z: 3).x, 8)
        XCTAssertEqual(Position(w: 6, x: 8, y: 4, z: 3).y, 4)
        XCTAssertEqual(Position(w: 6, x: 8, y: 4, z: 3).z, 3)
    }

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

    func testNeighbours2D() {
        let neighbours = Position2D.origin.neighbours
        XCTAssertEqual(neighbours.count, 8)
        XCTAssert(neighbours.contains(Position(x: -1, y: -1)))
        XCTAssert(neighbours.contains(Position(x: -1, y:  0)))
        XCTAssert(neighbours.contains(Position(x: -1, y:  1)))
        XCTAssert(neighbours.contains(Position(x:  0, y: -1)))
        XCTAssert(neighbours.contains(Position(x:  0, y:  1)))
        XCTAssert(neighbours.contains(Position(x:  1, y: -1)))
        XCTAssert(neighbours.contains(Position(x:  1, y:  0)))
        XCTAssert(neighbours.contains(Position(x:  1, y:  1)))
    }

    func testNeighbours3D() {
        let neighbours = Position3D.origin.neighbours
        XCTAssertEqual(neighbours.count, 26)
        XCTAssert(neighbours.contains(Position(x: -1, y: -1, z: -1)))
        XCTAssert(neighbours.contains(Position(x: -1, y: -1, z:  0)))
        XCTAssert(neighbours.contains(Position(x: -1, y: -1, z:  1)))
        XCTAssert(neighbours.contains(Position(x: -1, y:  0, z: -1)))
        XCTAssert(neighbours.contains(Position(x: -1, y:  0, z:  0)))
        XCTAssert(neighbours.contains(Position(x: -1, y:  0, z:  1)))
        XCTAssert(neighbours.contains(Position(x: -1, y:  1, z: -1)))
        XCTAssert(neighbours.contains(Position(x: -1, y:  1, z:  0)))
        XCTAssert(neighbours.contains(Position(x: -1, y:  1, z:  1)))
        XCTAssert(neighbours.contains(Position(x:  0, y: -1, z: -1)))
        XCTAssert(neighbours.contains(Position(x:  0, y: -1, z:  0)))
        XCTAssert(neighbours.contains(Position(x:  0, y: -1, z:  1)))
        XCTAssert(neighbours.contains(Position(x:  0, y:  0, z: -1)))
        XCTAssert(neighbours.contains(Position(x:  0, y:  0, z:  1)))
        XCTAssert(neighbours.contains(Position(x:  0, y:  1, z: -1)))
        XCTAssert(neighbours.contains(Position(x:  0, y:  1, z:  0)))
        XCTAssert(neighbours.contains(Position(x:  0, y:  1, z:  1)))
        XCTAssert(neighbours.contains(Position(x:  1, y: -1, z: -1)))
        XCTAssert(neighbours.contains(Position(x:  1, y: -1, z:  0)))
        XCTAssert(neighbours.contains(Position(x:  1, y: -1, z:  1)))
        XCTAssert(neighbours.contains(Position(x:  1, y:  0, z: -1)))
        XCTAssert(neighbours.contains(Position(x:  1, y:  0, z:  0)))
        XCTAssert(neighbours.contains(Position(x:  1, y:  0, z:  1)))
        XCTAssert(neighbours.contains(Position(x:  1, y:  1, z: -1)))
        XCTAssert(neighbours.contains(Position(x:  1, y:  1, z:  0)))
        XCTAssert(neighbours.contains(Position(x:  1, y:  1, z:  1)))
    }

//    func testRotate() {
//        XCTAssertEqual(
//            mutating(Position(x: 1, y: 2)) { $0.transform(.rotate270) },
//            Position(x: -2, y: 1)
//        )
//        XCTAssertEqual(
//            mutating(Position(x: 2, y: 1)) { $0.transform(.rotate90) },
//            Position(x: 1, y: -2)
//        )
//    }

    func testRotating() {
        XCTAssertEqual(
            Position(x: 1, y: -2).transforming(Transform2D.rotate270),
            Position(x: 2, y: 1)
        )
        XCTAssertEqual(
            Position(x: 1, y: -2).transforming(Transform2D.rotate90),
            Position(x: -2, y: -1)
        )
    }
}
