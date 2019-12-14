
import Advent
import Foundation

public struct Day14 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        Reactor(input: input).create(.fuel, amount: 1)
    }

    public func part2(input: Input) throws -> Int {
        let reactor = Reactor(input: input)
        let storedOre = 1_000_000_000_000
        var excess: [Chemical: Int] = [:]
        var requiredOre = 0
        var fuel = 0

        for multiplier in (0...7).map({ 10.power($0) }).reversed() {

            while true {
                var localExcess = excess
                let ore = reactor.create(.fuel,
                                         amount: multiplier,
                                         excess: &localExcess)
                guard ore + requiredOre <= storedOre else { break }
                excess = localExcess
                requiredOre += ore
                fuel += multiplier
            }
        }

        return fuel
    }
}

fileprivate struct Reactor {
    let reactions: [Chemical: Reaction]
}

extension Reactor {

    func create(_  chemical: Chemical, amount: Int) -> Int {
        var excess: [Chemical: Int] = [:]
        return create(chemical, amount: amount, excess: &excess)
    }

    func create(
        _ chemical: Chemical,
        amount: Int,
        excess: inout [Chemical: Int]
    ) -> Int {

        guard chemical != .ore else { return amount }

        var required = amount
        if let excessAmount = excess[chemical], excessAmount > 0 {
            let used = required > excessAmount ? excessAmount : required
            required -= used
            excess[chemical]! -= used
        }

        guard required > 0 else { return 0 }

        let reaction = reactions[chemical]!.requiringAmount(required)
        excess[chemical] = reaction.output.amount - required

        return reaction.input.reduce(0) { (ore, chemical) -> Int in
            ore + create(chemical.key, amount: chemical.value, excess: &excess)
        }
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
    let output: (chemical: Chemical, amount: Int)
}

extension Reaction {

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

extension Reaction {

    func requiringAmount(_ amount: Int) -> Reaction {
        let multiplier = Int(ceil(Double(amount) / Double(output.amount)))
        return Reaction(input: input.mapValues { $0 * multiplier },
                        output: (output.0, output.1 * multiplier))
    }
}

// CustomStringConvertible

extension Chemical: CustomStringConvertible {
    var description: String { value }
}

extension Reaction: CustomStringConvertible {
    var description: String { "Reaction(input: \(input), output: \(output))" }
}
