
import Advent
import XCTest

final class VectorTests: XCTestCase {

    func testInitDirections() {
        XCTAssertEqual(Vector.up.x, 0)
        XCTAssertEqual(Vector.up.y, 1)
        XCTAssertEqual(Vector.down.x, 0)
        XCTAssertEqual(Vector.down.y, -1)
        XCTAssertEqual(Vector.left.x, -1)
        XCTAssertEqual(Vector.left.y, 0)
        XCTAssertEqual(Vector.right.x, 1)
        XCTAssertEqual(Vector.right.y, 0)

        XCTAssertEqual(Vector.north.x, 0)
        XCTAssertEqual(Vector.north.y, 1)
        XCTAssertEqual(Vector.east.x, 1)
        XCTAssertEqual(Vector.east.y, 0)
        XCTAssertEqual(Vector.south.x, 0)
        XCTAssertEqual(Vector.south.y, -1)
        XCTAssertEqual(Vector.west.x, -1)
        XCTAssertEqual(Vector.west.y, 0)
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

    func testTransform() {
        XCTAssertEqual(mutating(Vector2D<Int>.up) { $0.transform(.identity) }, .up)
        XCTAssertEqual(mutating(Vector2D<Int>.up) { $0.transform(.rotate90) }, .right)
        XCTAssertEqual(mutating(Vector2D<Int>.up) { $0.transform(.rotate270) }, .left)
        XCTAssertEqual(mutating(Vector2D<Int>.down) { $0.transform(.identity) }, .down)
        XCTAssertEqual(mutating(Vector2D<Int>.down) { $0.transform(.rotate90) }, .left)
        XCTAssertEqual(mutating(Vector2D<Int>.down) { $0.transform(.rotate270) }, .right)
        XCTAssertEqual(mutating(Vector2D<Int>.left) { $0.transform(.identity) }, .left)
        XCTAssertEqual(mutating(Vector2D<Int>.left) { $0.transform(.rotate90) }, .up)
        XCTAssertEqual(mutating(Vector2D<Int>.left) { $0.transform(.rotate270) }, .down)
        XCTAssertEqual(mutating(Vector2D<Int>.right) { $0.transform(.identity) }, .right)
        XCTAssertEqual(mutating(Vector2D<Int>.right) { $0.transform(.rotate90) }, .down)
        XCTAssertEqual(mutating(Vector2D<Int>.right) { $0.transform(.rotate270) }, .up)
    }

    func testTransforming() {
        XCTAssertEqual(Vector2D<Int>.up.transforming(.identity), .up)
        XCTAssertEqual(Vector2D<Int>.up.transforming(.rotate90), .right)
        XCTAssertEqual(Vector2D<Int>.up.transforming(.rotate270), .left)
        XCTAssertEqual(Vector2D<Int>.down.transforming(.identity), .down)
        XCTAssertEqual(Vector2D<Int>.down.transforming(.rotate90), .left)
        XCTAssertEqual(Vector2D<Int>.down.transforming(.rotate270), .right)
        XCTAssertEqual(Vector2D<Int>.left.transforming(.identity), .left)
        XCTAssertEqual(Vector2D<Int>.left.transforming(.rotate90), .up)
        XCTAssertEqual(Vector2D<Int>.left.transforming(.rotate270), .down)
        XCTAssertEqual(Vector2D<Int>.right.transforming(.identity), .right)
        XCTAssertEqual(Vector2D<Int>.right.transforming(.rotate90), .down)
        XCTAssertEqual(Vector2D<Int>.right.transforming(.rotate270), .up)
    }

    func testMultiply() {
        let vector = Vector(x: 3, y: 5) * 4
        XCTAssertEqual(vector.x, 12)
        XCTAssertEqual(vector.y, 20)
    }
}
