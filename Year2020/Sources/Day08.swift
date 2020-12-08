
import Advent
import Foundation

public enum Day08 {

    public static func part1(_ input: Input) throws -> Int {

        var accumulator = 0
        let instructions = try input.lines
            .map(Instruction.init)

        try? instructions.execute(value: &accumulator)
        return accumulator
    }

    public static func part2(_ input: Input) throws -> Int {

        let instructions = try input.lines
            .map(Instruction.init)

        for index in instructions.indices {

            let new = instructions
                .enumerated()
                .map { offset, instruction -> Instruction in
                    guard offset == index else { return instruction }
                    return instruction.flipped
                }

            do {
                var accumulator = 0
                try new.execute(value: &accumulator)
                return accumulator
            } catch {
                continue
            }
        }

        throw InfiniteLoop()
    }
}

struct InfiniteLoop: Error {}

extension Array where Element == Day08.Instruction {

    func execute(value: inout Int) throws {
        var visited = Set<Index>()
        var index = 0

        while !visited.contains(index) {
            if index == endIndex { return }
            visited.insert(index)
            let instruction = self[index]
            switch instruction.kind {
            case .nop: index += 1
            case .acc: index += 1; value += instruction.value
            case .jmp: index += instruction.value
            }
        }

        throw InfiniteLoop()
    }
}

extension Day08 {

    fileprivate struct Instruction {
        let kind: Kind
        let value: Int
    }
}

extension Day08.Instruction {

    enum Kind {
        case jmp
        case nop
        case acc
    }
}

extension Day08.Instruction {

    var flipped: Self {
        switch kind {
        case .acc: return Self(kind: .acc, value: value)
        case .jmp: return Self(kind: .nop, value: value)
        case .nop: return Self(kind: .jmp, value: value)
        }
    }
}

extension Day08.Instruction {

    init(string: String) throws {
        struct InstructionKindError: Error {}
        let regex = try RegularExpression(pattern: #"([a-z]{3}) ([+\-0-9]+)"#)
        let match = try regex.match(string)
        value = try match.integer(at: 1)
        switch try match.string(at: 0) {
        case "jmp": kind = .jmp
        case "nop": kind = .nop
        case "acc": kind = .acc
        default: throw InstructionKindError()
        }
    }
}

extension Day08.Instruction: CustomStringConvertible {
    var description: String { "Instruction(\(kind), \(value))" }
}
