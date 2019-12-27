
import Advent
import Foundation

public struct Day22 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        try Deck(count: 10_007).shuffleCard(at: 2019, instructions: input)
    }

    public func shuffle(cards: ClosedRange<Int>, input: Input) throws -> [Int] {
        let deck = Deck(count: cards.count)
        let endPositions = try cards.map { try deck.shuffleCard(at: $0, instructions: input) }
        let result = Array(repeating: 0, count: cards.count)
        return endPositions.enumerated().reduce(into: result) { (result, arg) in
            let (offset, element) = arg
            result[element] = offset
        }
    }
}

extension Day22 {

    public struct Deck {
        let count: Int
    }
}

extension Day22.Deck {

    func shuffleCard(
        at index: Int,
        instructions input: Input
    ) throws -> Int {

        try input
            .lines
            .map(Day22.Instruction.init(_:))
            .reduce(index) { index, instruction in
                switch instruction {
                case .newStack: return count - 1 - index
                case .cut(let value): return (count + index - value) % count
                case .increment(let value): return index * value % count
                }
            }
    }
}

// MARK: - Instruction

extension Day22 {

    fileprivate enum Instruction {
        case newStack
        case cut(Int)
        case increment(Int)
    }
}

extension Day22.Instruction: RawRepresentable {

    init?(rawValue: String) {

        let value = {
            rawValue
                .components(separatedBy: " ")
                .last
                .flatMap(Int.init)!
        }

        switch rawValue {
        case "deal into new stack": self = .newStack
        case .hasPrefix("cut"): self = .cut(value())
        case .hasPrefix("deal with increment"): self = .increment(value())
        default: return nil
        }
    }

    var rawValue: String {
        switch self {
        case .newStack: return "deal into new stack"
        case let .cut(value): return "cut \(value)"
        case let .increment(value): return "deal with increment \(value)"
        }
    }
}
