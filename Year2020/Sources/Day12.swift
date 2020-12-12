
import Advent
import Foundation

public enum Day12 {

    public static func part1(_ input: Input) throws -> Int {

        let instructions = try Array(instructions: input)
        var ship = Position.origin
        var heading = Vector<Int>.east
        for instruction in instructions {
            switch instruction.kind {
            case .N: ship.move(.north * instruction.amount)
            case .E: ship.move(.east * instruction.amount)
            case .S: ship.move(.south * instruction.amount)
            case .W: ship.move(.west * instruction.amount)
            case .F: ship.move(heading * instruction.amount)
            case .L: heading.rotate(.left, instruction.amount/90)
            case .R: heading.rotate(.right, instruction.amount/90)
            }
        }

        return Position.origin.manhattenDistance(to: ship)
    }

    public static func part2(_ input: Input) throws -> Int {

        let instructions = try Array(instructions: input)
        var ship = Position.origin
        var waypoint = Position(x: 10, y: 1)
        for instruction in instructions {
            switch instruction.kind {
            case .N: waypoint.move(.north * instruction.amount)
            case .E: waypoint.move(.east * instruction.amount)
            case .S: waypoint.move(.south * instruction.amount)
            case .W: waypoint.move(.west * instruction.amount)
            case .F: ship.move(Vector(to: waypoint) * instruction.amount)
            case .L: waypoint.rotate(.left, instruction.amount/90)
            case .R: waypoint.rotate(.right, instruction.amount/90)
            }
        }

        return Position.origin.manhattenDistance(to: ship)
    }
}

extension Day12 {

    fileprivate struct Instruction {
        let kind: Kind
        let amount: Int

        enum Kind: String, RawRepresentable {
            case N,S,E,W,L,R,F
        }
    }
}

extension Array where Element == Day12.Instruction {

    fileprivate init(instructions input: Input) throws {
        let regex = try RegularExpression(pattern: "^([NSEWLRF])([0-9]+)$")
        self = try input.lines.map(regex.match).map { match in
            try Day12.Instruction(
                kind: Day12.Instruction.Kind(match.string(at: 0)),
                amount: match.integer(at: 1))
        }
    }
}

extension Position {

    fileprivate mutating func rotate(_ turn: Turn, _ amount: Int) {
        (1...amount).forEach { _ in rotate(turn) }
    }
}

extension Vector {

    fileprivate mutating func rotate(_ turn: Turn, _ amount: Int) {
        (1...amount).forEach { _ in rotate(turn) }
    }
}
