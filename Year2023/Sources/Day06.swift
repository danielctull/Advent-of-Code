
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day06: Day {

    public static let title = "Wait For It"

    public static func part1(_ input: Input) throws -> Int {
        let output = try regex.match(in: input.string).output
        let times = output.1.map(\.1)
        let distances = output.2.map(\.1)

        return zip(times, distances).map { time, distance in
            (0...time)
                .map { hold in (time - hold) * hold }
                .filter { $0 > distance }
                .count
        }
        .product
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }

    public static let regex = Regex {
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
}
