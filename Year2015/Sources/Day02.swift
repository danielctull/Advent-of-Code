
import Advent
import Algorithms
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
                    .combinations(ofCount: 2)
                    .map { $0.product }
                    .repeatingElements(2)

                return sides.min()! + sides.sum

            }
            .sum
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
                    .sum

                let bow = lengths.reduce(1, *)

                return perimeter + bow
            }
            .sum
    }
}
