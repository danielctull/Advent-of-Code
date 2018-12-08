
import Advent
import Foundation

public struct Day05 {

    public init() {}

    public func part1(input: Input) -> Int {

        guard var result = input.lines.first?.string else {
            return 0
        }

        var previousResult = ""

        while result.count != previousResult.count {

            previousResult = result

            var previousCharacter: Character?

            result = previousResult.reduce(into: "") { result, character in

                guard let previous = previousCharacter else {
                    previousCharacter = character
                    return
                }

                if previous.isEqualButOppositeCase(to: character) {
                    previousCharacter = nil
                } else {
                    result.append(previous)
                    previousCharacter = character
                }
            }

            if let previousCharacter = previousCharacter {
                result.append(previousCharacter)
            }
        }

        return result.count
    }

    public func part2(input: Input) -> Int {
        return 100
    }
}

extension Character {

    func isEqualButOppositeCase(to character: Character) -> Bool {

        return character != self && String(character).uppercased() == String(self).uppercased()
    }
}
