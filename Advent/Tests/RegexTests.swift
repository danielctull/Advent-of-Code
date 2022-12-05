
import Advent
import XCTest

final class RegexTests: XCTestCase {

    func testMatches() throws {
        let regex = Regex { "A" }
        let matches = try regex.matches(in: "ABABAA")
        XCTAssertEqual(matches.count, 4)
    }
}
