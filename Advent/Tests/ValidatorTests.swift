
import Advent
import XCTest

final class ValidatorTests: XCTestCase {

    func testNone() {
        let validator = Validator<String>()
        XCTAssertTrue(validator.validate(""))
        XCTAssertTrue(validator.validate("1"))
        XCTAssertTrue(validator.validate("12"))
        XCTAssertTrue(validator.validate("123"))
    }

    func testClosure() {
        let validator = Validator<String>()
            .count { $0.isMultiple(of: 2) }
        XCTAssertTrue(validator.validate(""))
        XCTAssertFalse(validator.validate("1"))
        XCTAssertTrue(validator.validate("12"))
        XCTAssertFalse(validator.validate("123"))
    }

    func testPredicate() {
        let validator = Validator<String>()
            .count(.isWithin(2...3))
        XCTAssertFalse(validator.validate(""))
        XCTAssertFalse(validator.validate("1"))
        XCTAssertTrue(validator.validate("12"))
        XCTAssertTrue(validator.validate("123"))
        XCTAssertFalse(validator.validate("1234"))
    }

    func testPropertysProperty() {
        let validator = Validator<String>()
            .count.description(.is("2"))
        XCTAssertFalse(validator.validate(""))
        XCTAssertFalse(validator.validate("1"))
        XCTAssertTrue(validator.validate("12"))
        XCTAssertFalse(validator.validate("123"))
    }
}
