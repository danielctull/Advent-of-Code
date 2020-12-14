
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

    func testInit() {
        XCTAssertEqual(BinaryNumber(3434).description, "110101101010")
    }

    func testDescription() {
        XCTAssertEqual(BinaryNumber(.one, .zero, .zero, .zero).description, "1000")
        XCTAssertEqual(BinaryNumber(.zero, .zero, .one, .zero).description, "0010")
    }

    func test() {
        XCTAssertEqual(mutating(BinaryNumber(.one)) { $0[$0.endIndex] = .zero }.description, "01")
    }
}
