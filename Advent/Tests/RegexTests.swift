
import Advent
import RegexBuilder
import XCTest

final class RegexTests: XCTestCase {

    func testMatches() throws {
        let regex = Regex { "A" }
        let matches = try regex.matches(in: "ABABAA")
        XCTAssertEqual(matches.count, 4)
    }

    func testTryCaptureRawRepresentable() throws {

        enum Value: Character, Equatable {
            case one = "1"
            case two = "2"
            case three = "3"
        }

        let regex = Regex { TryCapture(Value.self) }
        XCTAssertEqual(try regex.match(in: "1").output.1, .one)
        XCTAssertEqual(try regex.match(in: "2").output.1, .two)
        XCTAssertEqual(try regex.match(in: "3").output.1, .three)
        XCTAssertThrowsError(try regex.match(in: "4")) {
            XCTAssert($0 is NoRegexMatch)
        }
    }
}
