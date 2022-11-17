
import Advent
import Algorithms
import Foundation

public enum Day05: Day {

    public static let title = "Doesn't He Have Intern-Elves For This?"

    public static func part1(_ input: Input) throws -> Int {

        input.lines
            .filter(.threeVowels)
            .filter(.consecutiveCharacters)
            .filter(!.badStrings)
            .count
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Predicate where Value == String {

    fileprivate static var threeVowels: Self {
        let vowels: [Character] = ["a", "e", "i", "o", "u"]
        return Predicate { $0.count(where: vowels.contains) >= 3 }
    }

    fileprivate static var consecutiveCharacters: Self {
        Predicate { $0.adjacentPairs().contains(where: ==) }
    }

    fileprivate static var badStrings: Self {
        ["ab", "cd", "pq", "xy"]
            .map(Predicate.contains)
            .reduce(.false) { $0 || $1 }
    }

    fileprivate static func contains(_ value: String) -> Self {
        Predicate { $0.contains(value) }
    }
}
