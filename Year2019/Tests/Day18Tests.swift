
import Advent
import Year2019
import XCTest

final class Day18Tests: XCTestCase {

    func testPart1Example1() throws {
        let result = try Day18().part1(input: [
            "#########",
            "#b.A.@.a#",
            "#########"
        ])
        XCTAssertEqual(result, 8)
    }

    func testPart1Example2() throws {
        let result = try Day18().part1(input: [
            "########################",
            "#f.D.E.e.C.b.A.@.a.B.c.#",
            "######################.#",
            "#d.....................#",
            "########################"
        ])
        XCTAssertEqual(result, 86)
    }

    func testPart1Example3() throws {
        let result = try Day18().part1(input: [
            "########################",
            "#...............b.C.D.f#",
            "#.######################",
            "#.....@.a.B.c.d.A.e.F.g#",
            "########################"
        ])
        XCTAssertEqual(result, 132)
    }

    func testPart1Example4() throws {
        let result = try Day18().part1(input: [
            "#################",
            "#i.G..c...e..H.p#",
            "########.########",
            "#j.A..b...f..D.o#",
            "########@########",
            "#k.E..a...g..B.n#",
            "########.########",
            "#l.F..d...h..C.m#",
            "#################"
        ])
        XCTAssertEqual(result, 136)
    }

    func testPart1Example5() throws {
        let result = try Day18().part1(input: [
            "########################",
            "#@..............ac.GI.b#",
            "###d#e#f################",
            "###A#B#C################",
            "###g#h#i################",
            "########################"
        ])
        XCTAssertEqual(result, 81)
    }

    func testPart1Puzzle() throws {
        let day = Day18()
        let file = try Input(named: "Day18")
        let result = try day.part1(input: file)
        XCTAssertEqual(result, 0)
    }
}
