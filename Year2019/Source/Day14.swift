
import Advent
import Foundation

public struct Day14 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        let processor = FuelProcessor(input: input)
        var excess: [String] = []
        var requiredOre = 0
        processor.createFuel(excess: &excess, ore: &requiredOre)
        return requiredOre
    }

    public func part2(input: Input) throws -> Int {
        let processor = FuelProcessor(input: input)
        let storedOre = 1000000000000
        var excess: [String] = []
        var requiredOre = 0
        var fuel = 0

        repeat {
            processor.createFuel(excess: &excess, ore: &requiredOre)
            fuel += 1
        } while requiredOre < storedOre && excess.count != 0

        let amount = storedOre / requiredOre
        fuel *= amount
        requiredOre *= amount

        repeat {
            processor.createFuel(excess: &excess, ore: &requiredOre)
            fuel += 1
        } while requiredOre < storedOre

        return fuel - 1 // Take into account the over production in the final loop.
    }
}

fileprivate struct FuelProcessor {

    let reactions: [String: Reaction]

    func createFuel(excess: inout [String], ore: inout Int) {

        var required = reactions["FUEL"]!.input

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
    }

    init(input: Input) {
        reactions = input
            .lines
            .map { Reaction($0.string) }
            .group(by: { $0.output[0] })
            .mapValues { $0[0] }
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
