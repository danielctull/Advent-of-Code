
import Advent
import Algorithms
import Foundation

public enum Day05 {

    public static func part1(_ input: Input) throws -> Int {

        input.lines
            .map { Seat($0).number }
            .max() ?? 0
    }

    public static func part2(_ input: Input) -> Int {

        input.lines
            .map { Seat($0).number }
            .sorted()
            .slidingWindows(ofCount: 2)
            .first(where: { $0.last! - $0.first! == 2 }) //Find gap in seats.
            .map { $0.first! + 1 } ?? 0
    }

    private struct Seat {
        let row: BinaryNumber
        let column: BinaryNumber
        init(_ string: String) {
            let array = Array(string)
            row = BinaryNumber(bits: array[0...6].map {
                switch $0 {
                case "F": return .zero
                case "B": return .one
                default: fatalError()
                }
            })
            column = BinaryNumber(bits: array[7...9].map {
                switch $0 {
                case "L": return .zero
                case "R": return .one
                default: fatalError()
                }
            })
        }

        var number: Int { Int(row) * 8 + Int(column) }
    }
}

struct BinaryNumber {
    let bits: [Bit]
}

enum Bit {
    case zero
    case one
}

extension Int {

    init(_ bit: Bit) {
        switch bit {
        case .zero: self = 0
        case .one: self = 1
        }
    }

    init(_ binaryNumber: BinaryNumber) {
        self = binaryNumber.bits.reduce(0) { $0 * 2 + Int($1) }
    }
}
