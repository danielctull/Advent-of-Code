
import Advent
import Foundation

public struct Day12 {

    public init() {}

    public func part1(input: Input) -> Int {

        let lines = input.lines.map { $0.string }

        let initial = lines[0].replacingOccurrences(of: "initial state: ", with: "")
        let rules: [String: String] = lines.dropFirst(2).reduce(into: [:]) { result, string in
            let components = string.components(separatedBy: " => ")
            result[components[0]] = components[1]
        }

        let generations = 20
        let overflow = 2 * generations
        let overflowString = String(repeating: ".", count: overflow)
        let working = overflowString + initial + overflowString

        return (1...generations)
            .accumulating(working) { previous, _ in

                // Needed to get lookingAhead to work without dropping pots.
                let extended = ".." + previous + ".."

                return extended.lookingAhead(5).map { chars -> String in
                    let string = String(chars)
                    let replacement = rules[string]
                    return replacement ?? "."
                }.reduce("", +)
            }
            .map { $0 }
            .last!
            .enumerated()
            .compactMap {

                guard String($0.1) == "#" else {
                    return nil
                }

                return $0.0 - overflow

            }.reduce(0, +)
    }
}
