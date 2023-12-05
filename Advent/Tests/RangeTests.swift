
import Advent
import XCTest

final class RangeTests: XCTestCase {
    
    func testContains() {
        XCTAssertTrue((0..<1).contains(0..<1))
        XCTAssertTrue((0..<2).contains(0..<1))
        XCTAssertTrue((0..<2).contains(1..<2))
        XCTAssertTrue((0..<3).contains(1..<2))
        XCTAssertFalse((2..<3).contains(1..<2))
        XCTAssertFalse((0..<1).contains(1..<2))
    }

    //    012345
    // a: ||
    // b: ||
    func testIntersection_01() {
        let a = 0..<2
        let b = 0..<2
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 0..<2)
        XCTAssertEqual(remainder, [])
    }

    //    012345
    // a: |--|
    // b:  ||
    func testIntersection_02() {
        let a = 0..<4
        let b = 1..<3
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 1..<3)
        XCTAssertEqual(remainder, [])
    }

    //    012345
    // a:  ||
    // b: |--|
    func testIntersection_02_flipped() {
        let a = 1..<3
        let b = 0..<4
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 1..<3)
        XCTAssertEqual(remainder, [0..<1, 3..<4])
    }

    //    012345
    // a: |-|
    // b: ||
    func testIntersection_03() {
        let a = 0..<3
        let b = 0..<2
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 0..<2)
        XCTAssertEqual(remainder, [])
    }

    //    012345
    // a: ||
    // b: |-|
    func testIntersection_03_flipped() {
        let a = 0..<2
        let b = 0..<3
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 0..<2)
        XCTAssertEqual(remainder, [2..<3])
    }

    //    012345
    // a: |-|
    // b:  ||
    func testIntersection_04() {
        let a = 0..<3
        let b = 1..<3
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 1..<3)
        XCTAssertEqual(remainder, [])
    }

    //    012345
    // a:  ||
    // b: |-|
    func testIntersection_04_flipped() {
        let a = 1..<3
        let b = 0..<3
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 1..<3)
        XCTAssertEqual(remainder, [0..<1])
    }

    //    012345
    // a:  |-|
    // b: |-|
    func testIntersection_05() {
        let a = 1..<4
        let b = 0..<3
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 1..<3)
        XCTAssertEqual(remainder, [0..<1])
    }

    //    012345
    // a: |-|
    // b:  |-|
    func testIntersection_05_flipped() {
        let a = 0..<3
        let b = 1..<4
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 1..<3)
        XCTAssertEqual(remainder, [3..<4])
    }

    //    012345
    // a: ||
    // b:  ||
    func testIntersection_06() {
        let a = 0..<2
        let b = 1..<3
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 1..<2)
        XCTAssertEqual(remainder, [2..<3])
    }

    //    012345
    // a:  ||
    // b: ||
    func testIntersection_06_flipped() {
        let a = 1..<3
        let b = 0..<2
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 1..<2)
        XCTAssertEqual(remainder, [0..<1])
    }

    //    012345
    // a: ||
    // b:   ||
    func testIntersection_07() {
        let a = 0..<2
        let b = 2..<4
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, nil)
        XCTAssertEqual(remainder, [2..<4])
    }

    //    012345
    // a:   ||
    // b: ||
    func testIntersection_07_flipped() {
        let a = 2..<4
        let b = 0..<2
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, nil)
        XCTAssertEqual(remainder, [0..<2])
    }

    //    012345
    // a: ||
    // b:    ||
    func testIntersection_08() {
        let a = 0..<2
        let b = 3..<5
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, nil)
        XCTAssertEqual(remainder, [3..<5])
    }

    //    012345
    // a:    ||
    // b: ||
    func testIntersection_08_flipped() {
        let a = 3..<5
        let b = 0..<2
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, nil)
        XCTAssertEqual(remainder, [0..<2])
    }

    func testIntersection() {
        let a = 64..<77
        let b = 74..<77
        let (intersection, remainder) = a.intersection(b)
        XCTAssertEqual(intersection, 74..<77)
        XCTAssertEqual(remainder, [])
    }
}
