
import Advent
import Algorithms
import Foundation

public enum Day01: Day {

    public static let title = "Sonar Sweep"

    public static func part1(_ input: Input) throws -> Int {
        input.integers
            .adjacentPairs()
            .map(<)
            .count(of: true)
    }

    public static func part2(_ input: Input) throws -> Int {
        input.integers
            .windows(ofCount: 3)
            .map { $0.sum() }
            .adjacentPairs()
            .map(<)
            .count(of: true)
    }
}
