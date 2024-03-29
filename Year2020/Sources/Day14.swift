
import Advent
import Foundation

public enum Day14: Day {

    public static let title = "Docking Data"

    public static func part1(_ input: Input) throws -> Int {

        let instructions = try Array(instructions: input.lines)
        var ones = Int(BinaryNumber(bits: Array(repeating: .one, count: 36)))
        var zeros = Int(BinaryNumber(bits: Array(repeating: .one, count: 36)))
        var memory: [Int:Int] = [:]

        for instruction in instructions {
            switch instruction {
            case let .updateMask(mask):
                zeros = Int(BinaryNumber(zeros: mask))
                ones = Int(BinaryNumber(ones: mask))
            case .write(let address, var value):
                value &= zeros
                value |= ones
                memory[address] = value
            }
        }

        return memory.values.sum
    }

    public static func part2(_ input: Input) throws -> Int {

        let instructions = try Array(instructions: input.lines)
        var ones = Int(BinaryNumber(bits: Array(repeating: .one, count: 36)))
        var xPositions: [BinaryNumber.Index] = []
        var memory: [Int:Int] = [:]

        for instruction in instructions {
            switch instruction {
            case let .updateMask(mask):
                ones = Int(BinaryNumber(ones: mask))
                xPositions = BinaryNumber(exes: mask)
                    .indexed()
                    .filter { $0.element == .one }
                    .map(\.index)
            case .write(var address, let value):
                address |= ones
                
                var addresses = [BinaryNumber(address)]
                for xPosition in xPositions {
                    addresses = addresses.flatMap { number -> [BinaryNumber] in
                        let one = mutating(number) { $0[xPosition] = .one }
                        let zero = mutating(number) { $0[xPosition] = .zero }
                        return [one, zero]
                    }
                }

                for address in addresses {
                    memory[Int(address)] = value
                }
            }
        }

        return memory.values.sum
    }
}

extension Day14 {

    enum Instruction {
        case updateMask(String)
        case write(address: Int, value: Int)
    }
}

extension Array where Element == Day14.Instruction {

    fileprivate init<S>(instructions: S) throws where S: Sequence, S.Element == String {
        let update = try RegularExpression(pattern: "mask = ([01X]+)")
        let write = try RegularExpression(pattern: #"mem\[([0-9]+)\] = ([0-9]+)"#)
        self = try instructions.compactMap {
            if let match = try? write.match($0) {
                return try Day14.Instruction.write(
                    address: match.integer(at: 0),
                    value: match.integer(at: 1))
            }
            if let match = try? update.match($0) {
                return try Day14.Instruction.updateMask(match.string(at: 0))
            }
            return nil
        }
    }
}

extension BinaryNumber {

    fileprivate init(ones: String) {
        self.init(bits: ones.map {
            switch $0 {
            case "1": return .one
            default: return .zero
            }
        })
    }

    fileprivate init(zeros: String) {
        self.init(bits: zeros.map {
            switch $0 {
            case "0": return .zero
            default: return .one
            }
        })
    }

    fileprivate init(exes: String) {
        self.init(bits: exes.map {
            switch $0 {
            case "X": return .one
            default: return .zero
            }
        })
    }
}
