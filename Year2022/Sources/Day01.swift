
import Advent
import Algorithms
import Foundation

public enum Day01: Day {

    public static let title = "Calorie Counting"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .split(whereSeparator: \.isEmpty)
            .map { try $0.map(Int.init).sum }
            .max().unwrapped
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .split(whereSeparator: \.isEmpty)
            .map { try $0.map(Int.init).sum }
            .sorted(by: >)
            .chunks(ofCount: 3)
            .first.unwrapped.sum
    }
}

extension Int {

    fileprivate init(_ string: String) throws {
        self = try Int(string).unwrapped
    }
}
