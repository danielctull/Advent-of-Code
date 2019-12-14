
import Advent
import Foundation

public struct Day14 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        let processor = FuelProcessor(input: input)
        var excess: [Chemical: Int] = [:]
        var requiredOre = 0
        processor.createFuel(excess: &excess, ore: &requiredOre)
        return requiredOre
    }

    public func part2(input: Input) throws -> Int {
        let processor = FuelProcessor(input: input)
        let storedOre = 1000000000000
        var excess: [Chemical: Int] = [:]
        var requiredOre = 0
        var fuel = 0

        repeat {
            processor.createFuel(excess: &excess, ore: &requiredOre)
            fuel += 1
        } while requiredOre < storedOre && excess.filter({ $0.value > 0 }).count > 0

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

    let reactions: [Chemical: Reaction]

    func createFuel(excess: inout [Chemical: Int], ore: inout Int) {

        var required = reactions[.fuel]!.input

        while let (chemical, amount) = required.first(where: { $0.value > 0 && $0.key != .ore }) {

            if let excessChemical = excess[chemical], excessChemical > 0 {
                let remainingRequired = max(amount - excessChemical, 0)
                let remainingExcess = max(excessChemical - amount, 0)
                required[chemical] = remainingRequired
                excess[chemical] = remainingExcess
            } else {
                let reaction = reactions[chemical]!
                required.merge(reaction.input, uniquingKeysWith: +)
                excess[chemical, default: 0] += reaction.output.1
            }
        }

        ore += required[.ore]!
    }

    init(input: Input) {
        reactions = input
            .lines
            .map { Reaction($0.string) }
            .group(by: { $0.output.0 })
            .mapValues { $0[0] }
    }
}

fileprivate struct Chemical: Equatable, Hashable {
    static let ore = Chemical(value: "ORE")
    static let fuel = Chemical(value: "FUEL")
    let value: String
}

fileprivate struct Reaction {
    let input: [Chemical: Int]
    let output: (Chemical, Int)

    init(_ string: String) {

        func chemicals(from string: String) -> (Chemical, Int) {
            let values = string
                .trimmingCharacters(in: .whitespaces)
                .components(separatedBy: " ")
            let chemical = Chemical(value: values[1])
            let amount = Int(values[0])!
            return (chemical, amount)
        }

        let recipe = string.components(separatedBy: "=>")
        output = chemicals(from: recipe[1])

        input = recipe[0]
            .components(separatedBy: ",")
            .map(chemicals(from:))
            .group(by: { $0.0 })
            .mapValues { $0[0].1 }
    }
}
