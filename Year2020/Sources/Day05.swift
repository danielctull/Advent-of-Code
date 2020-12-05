
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
        0
    }

    private enum Split {
        case lower
        case upper
    }

    private struct Seat {
        let row: [Split]
        let column: [Split]
        init(_ string: String) {
            let array = Array(string)
            row = array[0...6].map {
                switch $0 {
                case "F": return .lower
                case "B": return .upper
                default: fatalError()
                }
            }
            column = array[7...9].map {
                switch $0 {
                case "L": return .lower
                case "R": return .upper
                default: fatalError()
                }
            }
        }

        var number: Int {
            func split(range: ClosedRange<Int>, split: Split) -> ClosedRange<Int> {
                let half = range.count / 2
                switch split {
                case .lower: return (range.lowerBound...range.upperBound-half)
                case .upper: return (range.lowerBound+half...range.upperBound)
                }
            }
            let r = row.reduce((0...127), split).lowerBound
            let c = column.reduce((0...7), split).lowerBound
            return r * 8 + c
        }
    }
}
