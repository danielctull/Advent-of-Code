
import Advent
import Foundation

public enum Day06 {

    public static func part1(_ input: Input) -> Int {

        input.lines
            .split(separator: "")
            .map { $0.joined(separator: "") }
            .map(Set.init)
            .sum(of: \.count)
    }

    public static func part2(_ input: Input) -> Int {

        input.lines
            .map(Set.init)
            .split(whereSeparator: \.isEmpty)
            .compactMap { $0.reduce { $0.intersection($1) } }
            .sum(of: \.count)
    }
}
