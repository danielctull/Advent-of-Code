
import Advent
import XCTest

final class VectorTests: XCTestCase {

    func testInitDirections() {
        XCTAssertEqual(Vector.up.dx, 0)
        XCTAssertEqual(Vector.up.dy, 1)
        XCTAssertEqual(Vector.down.dx, 0)
        XCTAssertEqual(Vector.down.dy, -1)
        XCTAssertEqual(Vector.left.dx, -1)
        XCTAssertEqual(Vector.left.dy, 0)
        XCTAssertEqual(Vector.right.dx, 1)
        XCTAssertEqual(Vector.right.dy, 0)

        XCTAssertEqual(Vector.north.dx, 0)
        XCTAssertEqual(Vector.north.dy, 1)
        XCTAssertEqual(Vector.east.dx, 1)
        XCTAssertEqual(Vector.east.dy, 0)
        XCTAssertEqual(Vector.south.dx, 0)
        XCTAssertEqual(Vector.south.dy, -1)
        XCTAssertEqual(Vector.west.dx, -1)
        XCTAssertEqual(Vector.west.dy, 0)
    }

    func testOpposite() {
        XCTAssertEqual(Vector<Int>.up.opposite, .down)
        XCTAssertEqual(Vector<Int>.down.opposite, .up)
        XCTAssertEqual(Vector<Int>.left.opposite, .right)
        XCTAssertEqual(Vector<Int>.right.opposite, .left)
    }

    func testOtherDirections() {
        XCTAssert(Vector<Int>.up.otherDirections.elementsEqual([.down, .left, .right]))
        XCTAssert(Vector<Int>.down.otherDirections.elementsEqual([.up, .left, .right]))
        XCTAssert(Vector<Int>.left.otherDirections.elementsEqual([.up, .down, .right]))
        XCTAssert(Vector<Int>.right.otherDirections.elementsEqual([.up, .down, .left]))
    }

    func testRotate() {
        XCTAssertEqual(mutating(Vector<Int>.up) { $0.rotate(.left) }, .left)
        XCTAssertEqual(mutating(Vector<Int>.up) { $0.rotate(.right) }, .right)
        XCTAssertEqual(mutating(Vector<Int>.down) { $0.rotate(.left) }, .right)
        XCTAssertEqual(mutating(Vector<Int>.down) { $0.rotate(.right) }, .left)
        XCTAssertEqual(mutating(Vector<Int>.left) { $0.rotate(.left) }, .down)
        XCTAssertEqual(mutating(Vector<Int>.left) { $0.rotate(.right) }, .up)
        XCTAssertEqual(mutating(Vector<Int>.right) { $0.rotate(.left) }, .up)
        XCTAssertEqual(mutating(Vector<Int>.right) { $0.rotate(.right) }, .down)
    }

    func testRotating() {
        XCTAssertEqual(Vector<Int>.up.rotating(.left), .left)
        XCTAssertEqual(Vector<Int>.up.rotating(.right), .right)
        XCTAssertEqual(Vector<Int>.down.rotating(.left), .right)
        XCTAssertEqual(Vector<Int>.down.rotating(.right), .left)
        XCTAssertEqual(Vector<Int>.left.rotating(.left), .down)
        XCTAssertEqual(Vector<Int>.left.rotating(.right), .up)
        XCTAssertEqual(Vector<Int>.right.rotating(.left), .up)
        XCTAssertEqual(Vector<Int>.right.rotating(.right), .down)
    }

    func testMultiply() {
        let vector = Vector(dx: 3, dy: 5) * 4
        XCTAssertEqual(vector.dx, 12)
        XCTAssertEqual(vector.dy, 20)
    }
}
