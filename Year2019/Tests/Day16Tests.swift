
import Advent
import Year2019
import XCTest

final class Day16Tests: XCTestCase {

    func testPart1Example1() {
        let result = Day16().part1(input: "12345678", phases: 4)
        XCTAssertEqual(result, "01029498")
    }

    func testPart1Example2() {
        let result = Day16().part1(input: "80871224585914546619083218645595")
        XCTAssertEqual(result, "24176176")
    }

    func testPart1Example3() {
        let result = Day16().part1(input: "19617804207202209144916044189917")
        XCTAssertEqual(result, "73745418")
    }

    func testPart1Example4() {
        let result = Day16().part1(input: "69317163492948606335995924319873")
        XCTAssertEqual(result, "52432133")
    }

    func testPart1Puzzle() throws {
        let day = Day16()
        let file = try Input(named: "Day16")
        let result = day.part1(input: file)
        XCTAssertEqual(result, "34694616")
    }

    func testPart2Example1() {
        let result = Day16().part2(input: "03036732577212944063491565474664")
        XCTAssertEqual(result, "84462026")
    }

    func testPart2Example2() {
        let result = Day16().part2(input: "02935109699940807407585447034323")
        XCTAssertEqual(result, "78725270")
    }

    func testPart2Example3() {
        let result = Day16().part2(input: "03081770884921959731165446850517")
        XCTAssertEqual(result, "53553731")
    }

    func testPart2Puzzle() throws {
        let day = Day16()
        let file = try Input(named: "Day16")
        let result = day.part2(input: file)
        XCTAssertEqual(result, "17069048")
    }
}
