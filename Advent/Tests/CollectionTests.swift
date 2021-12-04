
import Advent
import XCTest

final class CollectionTests: XCTestCase {

    func testTranspose() {
        let collection = [
            ["A1", "B1", "C1"],
            ["A2", "B2", "C2"],
            ["A3", "B3", "C3"],
            ["A4", "B4", "C4"],
        ]

        XCTAssertEqual(collection.transpose(), [
            ["A1", "A2", "A3", "A4"],
            ["B1", "B2", "B3", "B4"],
            ["C1", "C2", "C3", "C4"],
        ])
    }
}
