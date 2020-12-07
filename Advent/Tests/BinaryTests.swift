
import Advent
import XCTest

final class BinaryTests: XCTestCase {

    func testIntConversion() {
        XCTAssertEqual(Int(Bit.zero), 0)
        XCTAssertEqual(Int(Bit.one), 1)
        XCTAssertEqual(Int(BinaryNumber(.zero)), 0)
        XCTAssertEqual(Int(BinaryNumber(.one)), 1)
        XCTAssertEqual(Int(BinaryNumber(.one, .zero)), 2)
        XCTAssertEqual(Int(BinaryNumber(.one, .one)), 3)
    }
}
