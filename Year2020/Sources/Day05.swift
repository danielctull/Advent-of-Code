
import Advent
import Algorithms
import Foundation

public enum Day05: Day {

    public static let title = "Binary Boarding"

    public static func part1(_ input: Input) -> Int {

        input.lines
            .map { Int(BinaryNumber(seat: $0)) }
            .max() ?? 0
    }

    public static func part2(_ input: Input) -> Int {

        input.lines
            .map { Int(BinaryNumber(seat: $0)) }
            .sorted()
            .windows(ofCount: 2)
            .first(where: { $0.last! - $0.first! == 2 }) //Find gap in seats.
            .map { $0.first! + 1 } ?? 0
    }
}

extension BinaryNumber {

    fileprivate init(seat: String) {
        self.init(bits: seat.map {
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
