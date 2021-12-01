
import Advent
import Algorithms
import Foundation

public enum Day01: Day {

    public static let title = "Sonar Sweep"

    public static func part1(_ input: Input) throws -> Int {
        try input.integers
            .windows(ofCount: 2)
            .map { try $0.first.unwrapped() < $0.last.unwrapped() }
            .count(of: true)
    }

    public static func part2(_ input: Input) -> Int {
        0
    }
}
