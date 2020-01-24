
import Advent
import Foundation

public struct Day05 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .first!
            .reducingPolymer
            .count
    }

    public func part2(input: Input) -> Int {

        let characters = input
            .lines
            .first!

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

extension Sequence where Element == Character {

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
