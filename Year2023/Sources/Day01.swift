
import Advent
import Algorithms
import Foundation

public enum Day01: Day {

    public static let title = "Trebuchet?!"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map {
                let first = try $0.first(where: \.isNumber).unwrapped
                let last = try $0.last(where: \.isNumber).unwrapped
                return try Int("\(first)\(last)")
            }
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
