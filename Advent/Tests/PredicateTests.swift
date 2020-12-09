
import Advent
import XCTest

final class PredicateTests: XCTestCase {

    func testInit() {
        let truePredicate = Predicate<Int> { _ in true }
        let falsePredicate = Predicate<Int> { _ in false }
        XCTAssertTrue(truePredicate(1))
        XCTAssertFalse(falsePredicate(1))
    }

    func testPatternMatching() {
        switch "yes string" {
        case .hasPrefix("yes"): break
        default: XCTFail()
        }
        switch "no string" {
        case .hasPrefix("YES"): XCTFail()
        default: break
        }
    }

    func testAnd() {
        let predicate = Predicate { $0 > 0 } && Predicate { $0 < 2 }
        XCTAssertFalse(predicate(0))
        XCTAssertTrue(predicate(1))
        XCTAssertFalse(predicate(2))
    }

    func testOr() {
        let predicate = Predicate { $0 == "A" } || Predicate { $0 == "B" }
        XCTAssertTrue(predicate("A"))
        XCTAssertTrue(predicate("B"))
        XCTAssertFalse(predicate("C"))
    }

    func testNot() {
        let predicate = !Predicate.is("A")
        XCTAssertFalse(predicate("A"))
        XCTAssertTrue(predicate("B"))
        XCTAssertTrue(predicate("C"))
    }

    func testHasPrefix() {
        let predicate = Predicate.hasPrefix("yes")
        XCTAssertTrue(predicate("yes string"))
        XCTAssertFalse(predicate("no string"))
    }

    func testIs() {
        let predicate = Predicate.is("A")
        XCTAssertFalse(predicate(""))
        XCTAssertTrue(predicate("A"))
        XCTAssertFalse(predicate("B"))
    }

    func testIsWithinList() {
        let predicate = Predicate.isWithin("A", "B")
        XCTAssertFalse(predicate(""))
        XCTAssertTrue(predicate("A"))
        XCTAssertTrue(predicate("B"))
        XCTAssertFalse(predicate("C"))
    }

    func testIsWithinRange() {
        let predicate = Predicate<Int>.isWithin(1...2)
        XCTAssertFalse(predicate(0))
        XCTAssertTrue(predicate(1))
        XCTAssertTrue(predicate(2))
        XCTAssertFalse(predicate(3))
    }

    func testMatches() {
        let predicate = Predicate.matches("^[A-B][0-1]$")
        XCTAssertFalse(predicate("A"))
        XCTAssertFalse(predicate("B"))
        XCTAssertTrue(predicate("A0"))
        XCTAssertTrue(predicate("A1"))
        XCTAssertTrue(predicate("B0"))
        XCTAssertTrue(predicate("B1"))
        XCTAssertFalse(predicate("C0"))
        XCTAssertFalse(predicate("A2"))

        let failure = Predicate.matches("^[$")
        XCTAssertFalse(failure("A"))
        XCTAssertFalse(failure("B"))
        XCTAssertFalse(failure("A0"))
        XCTAssertFalse(failure("B1"))
    }
}
