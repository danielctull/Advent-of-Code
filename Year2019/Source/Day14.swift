
import Advent
import Foundation

public struct Day14 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let reactions = input
            .lines
            .map { Reaction($0.string) }
            .group(by: { $0.output[0] })
            .mapValues { $0[0] }

        var required = reactions["FUEL"]!.input
        var excess: [String] = []

        while let requiredIndex = required.firstIndex(where: { $0 != "ORE" }) {

            let chemical = required[requiredIndex]
            if let excessIndex = excess.firstIndex(of: chemical) {
                required.remove(at: requiredIndex)
                excess.remove(at: excessIndex)
            } else {
                let reaction = reactions[chemical]!
                required.append(contentsOf: reaction.input)
                excess.append(contentsOf: reaction.output)
            }
        }

        return required.count
    }
}

fileprivate struct Reaction {
    let input: [String]
    let output: [String]

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
        input = recipe[0].components(separatedBy: ",").flatMap(chemicals(from:))
    }
}
