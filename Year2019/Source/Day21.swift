
import Advent
import Foundation

public struct Day21 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        var computer = IntcodeComputer(input: input)
        try computer.springscript.input(
            .not(.a, .j),
            .not(.c, .t),
            .and(.d, .t),
            .or(.t, .j),
            .walk
        )
        try computer.run()
        return computer.output.last!
    }
}

// MARK: - Springscript and Intcode extensions

struct Springscript {
    fileprivate var computer: IntcodeComputer
}

extension Springscript {

    enum Register {
        case a, b, c, d, t, j
    }

    enum Instruction {
        case and(Register, Register)
        case not(Register, Register)
        case or(Register, Register)
        case walk
    }
}

extension IntcodeComputer {

    var springscript: Springscript {
        get { Springscript(computer: self) }
        set { self = newValue.computer }
    }
}

extension Springscript {

    mutating func input(_ instructions: Instruction...) throws {
        let string = instructions.map { $0.rawValue + "\n" }.joined()
        try computer.ascii.input(string)
    }
}

extension Springscript.Register: CustomStringConvertible {

    var description: String { String(rawValue) }
}

extension Springscript.Register: RawRepresentable {

    init?(rawValue: Character) {
        switch rawValue {
        case "A": self = .a
        case "B": self = .b
        case "C": self = .c
        case "D": self = .d
        case "T": self = .t
        case "J": self = .j
        default: return nil
        }
    }

    var rawValue: Character {
        switch self {
        case .a: return "A"
        case .b: return "B"
        case .c: return "C"
        case .d: return "D"
        case .t: return "T"
        case .j: return "J"
        }
    }
}

extension Springscript.Instruction: RawRepresentable {

    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: " ")

        let first = { try Springscript.Register(components[1].first!) }
        let second = { try Springscript.Register(components[2].first!) }

        do {
            switch components[0] {
            case "AND": self = try .and(first(), second())
            case "OR": self = try .or(first(), second())
            case "NOT": self = try .not(first(), second())
            case "WALK": self = .walk
            default: return nil
            }
        } catch { return nil }
    }

    var rawValue: String {
        switch self {
        case let .and(p1, p2): return "AND \(p1) \(p2)"
        case let .not(p1, p2): return "NOT \(p1) \(p2)"
        case let .or(p1, p2): return "OR \(p1) \(p2)"
        case .walk: return "WALK"
        }
    }
}
