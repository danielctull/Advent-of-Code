
import Advent
import RegexBuilder
import XCTest

final class PredicateTests: XCTestCase {

    func testInit() {
        let truePredicate = Advent.Predicate<Int> { _ in true }
        let falsePredicate = Advent.Predicate<Int> { _ in false }
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

    func testFalse() {
        let predicate = Advent.Predicate<Int>.false
        XCTAssertFalse(predicate(0))
        XCTAssertFalse(predicate(11))
        XCTAssertFalse(predicate(10000))
    }

    func testTrue() {
        let predicate = Advent.Predicate<Int>.true
        XCTAssertTrue(predicate(0))
        XCTAssertTrue(predicate(11))
        XCTAssertTrue(predicate(10000))
    }

    func testCount() {
        let predicate = Advent.Predicate<[Int]>.count(is: 2)
        XCTAssertFalse(predicate([]))
        XCTAssertFalse(predicate([0]))
        XCTAssertTrue(predicate([0, 1]))
        XCTAssertFalse(predicate([0, 1, 2]))
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

    func testIsGreaterThan() {
        let predicate = Predicate.isGreaterThan(2)
        XCTAssertFalse(predicate(0))
        XCTAssertFalse(predicate(1))
        XCTAssertFalse(predicate(2))
        XCTAssertTrue(predicate(3))
        XCTAssertTrue(predicate(4))
    }

    func testIsLessThan() {
        let predicate = Predicate.isLessThan(2)
        XCTAssertTrue(predicate(0))
        XCTAssertTrue(predicate(1))
        XCTAssertFalse(predicate(2))
        XCTAssertFalse(predicate(3))
    }

    func testIsSubset() {
        let predicate = Predicate.isSubset(of: Set(["A", "B"]))
        XCTAssertTrue(predicate([]))
        XCTAssertTrue(predicate(["A"]))
        XCTAssertTrue(predicate(["A", "B"]))
        XCTAssertFalse(predicate(["A", "B", "C"]))
        XCTAssertFalse(predicate(["A", "C"]))
    }

    func testIsSuperset() {
        let predicate = Predicate.isSuperset(of: Set(["A", "B"]))
        XCTAssertFalse(predicate([]))
        XCTAssertFalse(predicate(["A"]))
        XCTAssertTrue(predicate(["A", "B"]))
        XCTAssertTrue(predicate(["A", "B", "C"]))
        XCTAssertFalse(predicate(["A", "C"]))
    }

    func testContainedIn() {
        let predicate = Predicate.contained(in: ["A", "B"])
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

    func testWholeMatch() {
        let predicate = Predicate.wholeMatch(/[A-B][0-1]/)
        XCTAssertFalse(predicate("A"))
        XCTAssertFalse(predicate("B"))
        XCTAssertTrue(predicate("A0"))
        XCTAssertTrue(predicate("A1"))
        XCTAssertTrue(predicate("B0"))
        XCTAssertTrue(predicate("B1"))
        XCTAssertFalse(predicate("C0"))
        XCTAssertFalse(predicate("A2"))

        let failure = Predicate.wholeMatch(/^$/)
        XCTAssertFalse(failure("A"))
        XCTAssertFalse(failure("B"))
        XCTAssertFalse(failure("A0"))
        XCTAssertFalse(failure("B1"))
    }

    // MARK: - Sequence Extensions

    func testAllSatisfy() {
        XCTAssertTrue((0...10).allSatisfy(.isLessThan(11)))
        XCTAssertFalse((0...10).allSatisfy(.isLessThan(10)))
        XCTAssertFalse((0...10).allSatisfy(.is(2)))
    }

    func testCountWhere() {
        XCTAssertEqual((0...10).count(where: .is(2)), 1)
        XCTAssertEqual((0...10).count(where: .isLessThan(3)), 3)
        XCTAssertEqual((0...10).count(where: .isGreaterThan(3)), 7)
    }

    func testDropWhile() {
        XCTAssertTrue((0...10).drop(while: .is(0)).elementsEqual(1...10))
        XCTAssertTrue((0...10).drop(while: .isLessThan(3)).elementsEqual(3...10))
    }

    func testFirstWhere() {
        XCTAssertEqual((0...10).first(where: .is(2)), 2)
        XCTAssertEqual((0...10).first(where: .isLessThan(3)), 0)
        XCTAssertEqual((0...10).first(where: .isGreaterThan(3)), 4)
        XCTAssertNil((0...10).first(where: .is(11)))
    }
}
