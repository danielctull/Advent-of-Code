
import Advent
import Foundation

public struct Day14 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let reactions: [String: Reaction] = input
            .lines
            .map { Reaction($0.string) }
            .group(by: { $0.output[0] })
            .mapValues { $0[0] }

        var required = reactions["FUEL"]!.input
        var excess: [String] = []
        var ore = 0

        while let chemical = required.first {

            if let excessIndex = excess.firstIndex(of: chemical) {
                required.removeFirst()
                excess.remove(at: excessIndex)
            } else {
                let reaction = reactions[chemical]!
                required.append(contentsOf: reaction.input)
                excess.append(contentsOf: reaction.output)
                ore += reaction.ore
            }
        }

        return ore
    }
}

fileprivate struct Reaction {
    let input: [String]
    let output: [String]
    let ore: Int

    init(_ string: String) {

        func chemicals(from string: String) -> [String] {
            let values = string
                .trimmingCharacters(in: .whitespaces)
                .components(separatedBy: " ")
            let amount = Int(values[0])!
            let ingredient = values[1]
            return Array(repeating: ingredient, count: amount)
        }

        let recipe = string.components(separatedBy: "=>")
        output = chemicals(from: recipe[1])

        let inputChemicals = recipe[0]
            .components(separatedBy: ",")
            .flatMap(chemicals(from:))

        input = inputChemicals.filter { $0 != "ORE" }
        ore = inputChemicals.count - input.count
    }
}
