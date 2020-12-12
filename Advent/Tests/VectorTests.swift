
import Advent
import XCTest

final class VectorTests: XCTestCase {

    func testInitDirections() {
        XCTAssertEqual(Vector(direction: .up).x, 0)
        XCTAssertEqual(Vector(direction: .up).y, 1)
        XCTAssertEqual(Vector(direction: .down).x, 0)
        XCTAssertEqual(Vector(direction: .down).y, -1)
        XCTAssertEqual(Vector(direction: .left).x, -1)
        XCTAssertEqual(Vector(direction: .left).y, 0)
        XCTAssertEqual(Vector(direction: .right).x, 1)
        XCTAssertEqual(Vector(direction: .right).y, 0)
    }

    func testMultiply() {
        let vector = Vector(x: 3, y: 5) * 4
        XCTAssertEqual(vector.x, 12)
        XCTAssertEqual(vector.y, 20)
    }
}
