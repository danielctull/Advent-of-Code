
import Advent
import Foundation

public struct Day21 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        var computer = IntcodeComputer(input: input)
        try computer.springscript.input(
            .not(.ground(1), .jump), // No ground a 1, jump
            .not(.ground(2), .temporary), // Or no ground at 2, jump
            .or(.temporary, .jump),
            .not(.ground(3), .temporary), // Or no ground at 3, jump
            .or(.temporary, .jump),
            .and(.ground(4), .jump), // Make sure there is ground to land.
            .walk
        )
        try computer.run()
        return computer.output.last!
    }

    public func part2(input: Input) throws -> Int {

        var computer = IntcodeComputer(input: input)
        try computer.springscript.input(
            .not(.ground(1), .jump), // No ground a 1, jump
            .not(.ground(2), .temporary), // Or no ground at 2, jump
            .or(.temporary, .jump),
            .not(.ground(3), .temporary), // Or no ground at 3, jump
            .or(.temporary, .jump),
            .and(.ground(4), .jump), // Make sure there is ground to land.

            // Let's make sure there's ground at either 5 or 8 to continue
            // moving. We need to remove previous value in temporary, so perform
            // not twice to get actual value of 5 into temporary.
            .not(.ground(5), .temporary),
            .not(.temporary, .temporary),
            .or(.ground(8), .temporary),
            .and(.temporary, .jump),

            .run
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
        case ground(Int)
        case temporary
        case jump
    }

    enum Instruction {
        case and(Register, Register)
        case not(Register, Register)
        case or(Register, Register)
        case walk
        case run
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
        case "A": self = .ground(1)
        case "B": self = .ground(2)
        case "C": self = .ground(3)
        case "D": self = .ground(4)
        case "E": self = .ground(5)
        case "F": self = .ground(6)
        case "G": self = .ground(7)
        case "H": self = .ground(8)
        case "I": self = .ground(9)
        case "T": self = .temporary
        case "J": self = .jump
        default: return nil
        }
    }

    var rawValue: Character {
        switch self {
        case .ground(1): return "A"
        case .ground(2): return "B"
        case .ground(3): return "C"
        case .ground(4): return "D"
        case .ground(5): return "E"
        case .ground(6): return "F"
        case .ground(7): return "G"
        case .ground(8): return "H"
        case .ground(9): return "I"
        case .temporary: return "T"
        case .jump: return "J"
        default: fatalError()
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
            case "RUN": self = .run
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
        case .run: return "RUN"
        }
    }
}
