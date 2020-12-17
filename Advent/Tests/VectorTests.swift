
import Advent
import XCTest

final class VectorTests: XCTestCase {

    func testInitDirections() {
        XCTAssertEqual(Vector2D.up.x, 0)
        XCTAssertEqual(Vector2D.up.y, 1)
        XCTAssertEqual(Vector2D.down.x, 0)
        XCTAssertEqual(Vector2D.down.y, -1)
        XCTAssertEqual(Vector2D.left.x, -1)
        XCTAssertEqual(Vector2D.left.y, 0)
        XCTAssertEqual(Vector2D.right.x, 1)
        XCTAssertEqual(Vector2D.right.y, 0)

        XCTAssertEqual(Vector2D.north.x, 0)
        XCTAssertEqual(Vector2D.north.y, 1)
        XCTAssertEqual(Vector2D.east.x, 1)
        XCTAssertEqual(Vector2D.east.y, 0)
        XCTAssertEqual(Vector2D.south.x, 0)
        XCTAssertEqual(Vector2D.south.y, -1)
        XCTAssertEqual(Vector2D.west.x, -1)
        XCTAssertEqual(Vector2D.west.y, 0)
    }

    func testOpposite() {
        XCTAssertEqual(Vector2D<Int>.up.opposite, .down)
        XCTAssertEqual(Vector2D<Int>.down.opposite, .up)
        XCTAssertEqual(Vector2D<Int>.left.opposite, .right)
        XCTAssertEqual(Vector2D<Int>.right.opposite, .left)
    }

    func testOtherDirections() {
        XCTAssert(Vector2D<Int>.up.otherDirections.elementsEqual([.down, .left, .right]))
        XCTAssert(Vector2D<Int>.down.otherDirections.elementsEqual([.up, .left, .right]))
        XCTAssert(Vector2D<Int>.left.otherDirections.elementsEqual([.up, .down, .right]))
        XCTAssert(Vector2D<Int>.right.otherDirections.elementsEqual([.up, .down, .left]))
    }

    func testRotate() {
        XCTAssertEqual(mutating(Vector2D<Int>.up) { $0.rotate(.left) }, .left)
        XCTAssertEqual(mutating(Vector2D<Int>.up) { $0.rotate(.right) }, .right)
        XCTAssertEqual(mutating(Vector2D<Int>.down) { $0.rotate(.left) }, .right)
        XCTAssertEqual(mutating(Vector2D<Int>.down) { $0.rotate(.right) }, .left)
        XCTAssertEqual(mutating(Vector2D<Int>.left) { $0.rotate(.left) }, .down)
        XCTAssertEqual(mutating(Vector2D<Int>.left) { $0.rotate(.right) }, .up)
        XCTAssertEqual(mutating(Vector2D<Int>.right) { $0.rotate(.left) }, .up)
        XCTAssertEqual(mutating(Vector2D<Int>.right) { $0.rotate(.right) }, .down)
    }

    func testRotating() {
        XCTAssertEqual(Vector2D<Int>.up.rotating(.left), .left)
        XCTAssertEqual(Vector2D<Int>.up.rotating(.right), .right)
        XCTAssertEqual(Vector2D<Int>.down.rotating(.left), .right)
        XCTAssertEqual(Vector2D<Int>.down.rotating(.right), .left)
        XCTAssertEqual(Vector2D<Int>.left.rotating(.left), .down)
        XCTAssertEqual(Vector2D<Int>.left.rotating(.right), .up)
        XCTAssertEqual(Vector2D<Int>.right.rotating(.left), .up)
        XCTAssertEqual(Vector2D<Int>.right.rotating(.right), .down)
    }

    func testMultiply() {
        let vector = Vector2D(x: 3, y: 5) * 4
        XCTAssertEqual(vector.x, 12)
        XCTAssertEqual(vector.y, 20)
    }
}
