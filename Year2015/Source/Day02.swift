
import Advent
import Foundation

public struct Day02 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .map {

                let sides = $0
                    .components(separatedBy: "x")
                    .compactMap(Int.init)
                    .trianglePairs
                    .map(*)
                    .repeatingElements(2)

                return sides.min()! + sides.reduce(0, +)

            }
            .reduce(0, +)
    }

    public func part2(input: Input) -> Int {

        return input
            .lines
            .map {

                let lengths = $0
                    .components(separatedBy: "x")
                    .compactMap(Int.init)

                let perimeter = lengths
                    .sorted()
                    .dropLast()
                    .repeatingElements(2)
                    .reduce(0, +)

                let bow = lengths.reduce(1, *)

                return perimeter + bow
            }
            .reduce(0, +)
    }
}
