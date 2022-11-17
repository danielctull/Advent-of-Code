
import Advent
import XCTest

final class HashTests: XCTestCase {

    func testMD5() {
        XCTAssertEqual(Hash.md5("abcdef60904").description, "16d801f42de1f661cbd1f17ceb7cd3a5")
        XCTAssertEqual(Hash.md5("abcdef609043").description, "000001dbbfa3a5c83a2d506429c7b00e")

        XCTAssertTrue(Hash.md5("abcdef609043").description.hasPrefix("00000"))
    }
}
