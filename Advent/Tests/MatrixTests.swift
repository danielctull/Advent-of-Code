
import Advent
import XCTest

final class MatrixTests: XCTestCase {

    func testInitInput() throws {
        struct Tile: RawRepresentable, Equatable {
            let rawValue: Character
        }
        let matrix = try Matrix<Tile>(input: ["ABC","DEF","GHI"])
        try XCTAssertEqual(Array(matrix), [
            Tile("A"), Tile("B"), Tile("C"),
            Tile("D"), Tile("E"), Tile("F"),
            Tile("G"), Tile("H"), Tile("I")
        ])
    }

    func testDescription() {
        let matrix = Matrix(elements: [["A", "B", "C"], ["D", "E", "F"], ["G", "H", "I"]])
        XCTAssertEqual(matrix.description, """
            ABC
            DEF
            GHI
            """)
    }

    func testMap() {
        let matrix = Matrix(elements: [[1, 2], [3, 4]])
        let mapped = matrix.map { (p: Position, integer: Int) in String(integer) }
        XCTAssertEqual(Array(mapped), ["1", "2", "3", "4"])
        XCTAssertEqual(Array(mapped.positions), [
            Position(x: 0, y: 0), Position(x: 1, y: 0),
            Position(x: 0, y: 1), Position(x: 1, y: 1)
        ])
    }

    func testPositions() {
        let m = Matrix(elements: [["A", "B", "C"], ["D", "E", "F"], ["G", "H", "I"]])
        XCTAssertEqual(Array(m.positions), [
            Position(x: 0, y: 0), Position(x: 1, y: 0), Position(x: 2, y: 0),
            Position(x: 0, y: 1), Position(x: 1, y: 1), Position(x: 2, y: 1),
            Position(x: 0, y: 2), Position(x: 1, y: 2), Position(x: 2, y: 2),
        ])
    }

    func testSubscript() {
        let matrix = Matrix(elements: [[1, 2], [3, 4]])
        XCTAssertEqual(matrix[Position(x: 0, y: -1)], nil)
        XCTAssertEqual(matrix[Position(x: -1, y: 0)], nil)
        XCTAssertEqual(matrix[Position(x: 0, y: 0)], 1)
        XCTAssertEqual(matrix[Position(x: 1, y: 0)], 2)
        XCTAssertEqual(matrix[Position(x: 0, y: 1)], 3)
        XCTAssertEqual(matrix[Position(x: 1, y: 1)], 4)
        XCTAssertEqual(matrix[Position(x: 2, y: 0)], nil)
        XCTAssertEqual(matrix[Position(x: 1, y: 2)], nil)
    }
}
