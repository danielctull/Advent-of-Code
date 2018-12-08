
import Advent
import Foundation

public struct Day05 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .first?
            .string
            .map {$0}
            .reducingPolymer
            .count ?? 0
    }

    public func part2(input: Input) -> Int {

        guard let characters = input
            .lines
            .first?
            .string
            .map({$0})
        else {
            return 0
        }

        let uniqueCharacters = Set(characters.map { $0.lowercased })

        return uniqueCharacters.map { character in

            return characters
                .filter { $0.lowercased != character }
                .reducingPolymer
                .count

        }.min() ?? 0
    }
}

extension Character {

    var lowercased: Character {
        return Character(String(self).lowercased())
    }

    fileprivate func isPolarOpposite(to character: Character) -> Bool{
        return self != character && self.lowercased == character.lowercased
    }
}

extension Array where Element == Character {

    fileprivate var reducingPolymer: [Character] {

        return reduce(into: []) { result, character in

            if let previous = result.last, previous.isPolarOpposite(to: character) {
                result.removeLast()
            } else {
                result.append(character)
            }
        }
    }
}
