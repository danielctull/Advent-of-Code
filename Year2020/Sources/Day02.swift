
import Advent
import Foundation
import RegexBuilder

public enum Day02: Day {

    public static let title = "Password Philosophy"

    private static let regex = Regex {
        TryCapture.integer
        "-"
        TryCapture.integer
        " "
        TryCapture.character
        ": "
        Capture.string
    }

    public static func part1(_ input: Input) throws -> Int {

        try input.lines.count(where: { input in
            let match = try regex.match(in: input)
            let lower = match.output.1
            let upper = match.output.2
            let character = match.output.3
            let password = match.output.4
            let count = password.count(of: character)
            return (lower...upper).contains(count)
        })
    }

    public static func part2(_ input: Input) throws -> Int {

        try input.lines.count(where: { input in
            let match = try regex.match(in: input)
            let index1 = match.output.1 - 1
            let index2 = match.output.2 - 1
            let character = match.output.3
            let password = match.output.4
            let match1 = password.character(at: index1) == character
            let match2 = password.character(at: index2) == character
            return match1 != match2
        })
    }
}

extension String {

    fileprivate func character(at offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
