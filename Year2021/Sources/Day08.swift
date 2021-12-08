
import Advent
import Algorithms
import Foundation

public enum Day08: Day {

    public static let title = "Seven Segment Search"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .flatMap {
                try $0.split(separator: "|")
                    .last.unwrapped
                    .components(separatedBy: .whitespaces)
                    .map(\.count)
            }
            .count(where: [2,4,3,7].contains)
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
