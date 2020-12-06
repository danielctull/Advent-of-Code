
import Advent
import Foundation

public enum Day06 {

    public static func part1(_ input: Input) -> Int {
        input.lines
            .split(separator: "")
            .map { $0.joined(separator: "") }
            .map { Set($0).count }
            .sum()
    }

    public static func part2(_ input: Input) -> Int {

        input.lines
            .split(separator: "")
            .map { $0.map(Set.init) }
            .map { ($0.first!, $0.dropFirst()) }
            .map { head, tail in
                head.reduce(0) { count, character in
                    tail.allSatisfy { $0.contains(character) }
                        ? count + 1
                        : count
                }
            }
            .sum()
    }
}
