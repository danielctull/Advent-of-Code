
import Advent
import Foundation

public enum Day02: Day {

    public static let title = "Password Philosophy"

    public static func part1(_ input: Input) throws -> Int {

        let regex = try RegularExpression(pattern: "([0-9]+)-([0-9]+) (.): (.+)")
        return try input.lines.count(where: { input in
            let match = try regex.match(input)
            let lower = try match.integer(at: 0)
            let upper = try match.integer(at: 1)
            let character = try match.character(at: 2)
            let password = try match.string(at: 3)
            let count = password.count(of: character)
            return (lower...upper).contains(count)
        })
    }

    public static func part2(_ input: Input) throws -> Int {

        let regex = try RegularExpression(pattern: "([0-9]+)-([0-9]+) (.): (.+)")
        return try input.lines.count(where: { input in
            let match = try regex.match(input)
            let index1 = try match.integer(at: 0) - 1
            let index2 = try match.integer(at: 1) - 1
            let character = try match.character(at: 2)
            let password = try match.string(at: 3)
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
