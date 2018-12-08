
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
            .reducingPolymers
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
                .reducingPolymers
                .count

        }.min() ?? 0
    }
}

extension Character {

    var lowercased: Character {
        return Character(String(self).lowercased())
    }
}

extension Array where Element == Character {

    var reducingPolymers: [Character] {

        var result = self
        var previousResult: [Character] = []

        while result.count != previousResult.count {
            previousResult = result
            result = previousResult.removingPairs(shouldRemove: { lhs, rhs -> Bool in
                return lhs != rhs && lhs.lowercased == rhs.lowercased
            })
        }

        return result
    }
}


extension Sequence {

    func removingPairs(shouldRemove: (Element, Element) -> Bool) -> [Element] {

        var previousValue: Element?
        
        var result: [Element] = reduce(into: []) { result, value in

            guard let previous = previousValue else {
                previousValue = value
                return
            }

            if shouldRemove(previous, value) {
                previousValue = nil
            } else {
                result.append(previous)
                previousValue = value
            }
        }

        if let previousValue = previousValue {
            result.append(previousValue)
        }

        return result
    }
}
