
import Advent
import Foundation

public enum Day12: Day {

    public static let title = "Rain Risk"

    public static func part1(_ input: Input) throws -> Int {

        let instructions = try Array(instructions: input)
        var ship = Position.origin
        var heading = Vector<Int>.east
        for instruction in instructions {
            switch instruction.kind {
            case .N: ship += .north * instruction.amount
            case .E: ship += .east * instruction.amount
            case .S: ship += .south * instruction.amount
            case .W: ship += .west * instruction.amount
            case .F: ship += heading * instruction.amount
            case .L: heading.rotate(.left) * (instruction.amount / 90)
            case .R: heading.rotate(.right) * (instruction.amount / 90)
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
            case .N: waypoint += .north * instruction.amount
            case .E: waypoint += .east * instruction.amount
            case .S: waypoint += .south * instruction.amount
            case .W: waypoint += .west * instruction.amount
            case .F: ship += Vector(to: waypoint) * instruction.amount
            case .L: waypoint.rotate(.left) * (instruction.amount/90)
            case .R: waypoint.rotate(.right) * (instruction.amount/90)
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
