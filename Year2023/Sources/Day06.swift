
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day06: Day {

    public static let title = "Wait For It"

    public static func part1(_ input: Input) throws -> Int {
        let output = try regex1.match(in: input.string).output
        let times = output.1.map(\.1)
        let distances = output.2.map(\.1)

        return zip(times, distances).map { time, distance in
            (0...time)
                .filter(wins(time: time, distance: distance))
                .count
        }
        .product
    }

    public static func part2(_ input: Input) throws -> Int {
        let string = input.string.replacingOccurrences(of: " ", with: "")
        let output = try regex2.match(in: string).output
        let time = output.1
        let distance = output.2

        let first = try (0...time)
            .first(where: wins(time: time, distance: distance))
            .unwrapped

        let last = try (0...time)
            .last(where: wins(time: time, distance: distance))
            .unwrapped

        return last - first + 1
    }

    static func wins(time: Int, distance: Int) -> (Int) -> Bool {
        { hold in (time - hold) * hold > distance }
    }

    static let regex1 = Regex {
        "Time:"
        Capture {
            List {
                OneOrMore(.whitespace)
                TryCapture.integer
            }
        }
        One(.newlineSequence)
        "Distance:"
        Capture {
            List {
                OneOrMore(.whitespace)
                TryCapture.integer
            }
        }
    }

    static let regex2 = Regex {
        "Time:"
        TryCapture.integer
        One(.newlineSequence)
        "Distance:"
        TryCapture.integer
    }
}
