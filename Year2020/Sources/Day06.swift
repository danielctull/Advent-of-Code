
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
        0
    }
}
