
import Advent
import Foundation

public struct Day22 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let instructions = try input.lines.map { try Instruction($0.string) }
        let cards = Array(0...10_006)
        return cards
            .shuffled(with: instructions)
            .firstIndex(of: 2019)!
    }

    public func shuffle(cards: ClosedRange<Int>, input: Input) throws -> [Int] {
        let instructions = try input.lines.map { try Instruction($0.string) }
        return Array(cards).shuffled(with: instructions)
    }
}

extension Array {

    fileprivate func shuffled(with instructions: [Day22.Instruction]) -> Self {
        return instructions.reduce(self) { cards, instruction in
            switch instruction {
            case .newStack: return cards.reversed()
            case .cut(let value): return cards.cut(at: value)
            case .increment(let value): return cards.increment(with: value)
            }
        }
    }

    fileprivate func cut(at value: Int) -> Self {
        guard value != 0 else { return self }
        let value = value > 0 ? value : count + value
        return Array(self[value...] + self[..<value])
    }

    fileprivate func increment(with value: Int) -> Self {
        guard value != 0 else { return self }
        let result = Self(repeating: self[0], count: count)
        return enumerated().reduce(into: result) { (result, argument) in
            let (offset, element) = argument
            let index = offset * value % count
            result[index] = element
        }
    }
}

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
