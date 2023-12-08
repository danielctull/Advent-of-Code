
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day06: Day {

    public static let title = "Wait For It"

    public static func part1(_ input: Input) throws -> Int {
        let output = try regex1.match(in: input.string).output
        let times = output.1
        let distances = output.2
        return zip(times, distances)
            .map(wins)
            .product
    }

    public static func part2(_ input: Input) throws -> Int {
        let string = input.string.replacingOccurrences(of: " ", with: "")
        let output = try regex2.match(in: string).output
        return wins(time: output.1, distance: output.2)
    }

    // This is a quadratic equation!
    //
    // distance = (time - hold) * hold
    // distance / hold = time - hold
    // -hold = (distance / hold) - time
    // hold = time - (distance / hold)
    // hold^2 = (time * hold) - distance
    //      0 = (time * hold) - distance - hold^2
    //      0 = hold^2 - (time * hold) + distance
    //      0 = a.x^2 + b.x + c
    //    x = ( -b  ± sqrt(  b^2   -     4ac     )) / 2a
    // hold = (time ± sqrt(-time^2 - 4*1*distance)) / 2*1
    static func wins(time: Int, distance: Int) -> Int {
        let time = Double(time)
        let distance = Double(distance) + 0.1  // We need to be further than this
        let sqrt = sqrt(time * time - 4 * distance)
        let upper = floor((time + sqrt) / 2)
        let lower = ceil((time - sqrt) / 2)
        return Int(upper) - Int(lower) + 1
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
