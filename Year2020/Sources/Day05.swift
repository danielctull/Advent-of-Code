
import Advent
import Algorithms
import Foundation

public enum Day05 {

    public static func part1(_ input: Input) throws -> Int {

        input.lines
            .map { Seat($0).id }
            .max() ?? 0
    }

    public static func part2(_ input: Input) -> Int {

        input.lines
            .map { Seat($0).id }
            .sorted()
            .slidingWindows(ofCount: 2)
            .first(where: { $0.last! - $0.first! == 2 }) //Find gap in seats.
            .map { $0.first! + 1 } ?? 0
    }

    private struct Seat {
        var id: Int { Int(number) }
        private let number: BinaryNumber
        init(_ string: String) {
            number = BinaryNumber(bits: string.map {
                switch $0 {
                case "F": return .zero
                case "B": return .one
                case "L": return .zero
                case "R": return .one
                default: fatalError()
                }
            })
        }
    }
}
