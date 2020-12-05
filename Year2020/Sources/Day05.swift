
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

    private enum Bit {
        case zero
        case one

        var value: Int {
            switch self {
            case .one: return 1
            case .zero: return 0
            }
        }
    }

    private struct Seat {
        let row: [Bit]
        let column: [Bit]
        init(_ string: String) {
            let array = Array(string)
            row = array[0...6].map {
                switch $0 {
                case "F": return .zero
                case "B": return .one
                default: fatalError()
                }
            }
            column = array[7...9].map {
                switch $0 {
                case "L": return .zero
                case "R": return .one
                default: fatalError()
                }
            }
        }

        var number: Int {
            func calculate(previous: Int, bit: Bit) -> Int {
                previous * 2 + bit.value
            }
            let r = row.reduce(0, calculate)
            let c = column.reduce(0, calculate)
            return r * 8 + c
        }
    }
}
