
import Advent
import Foundation

public enum Day12 {

    public static func part1(_ input: Input) throws -> Int {

        let regex = try RegularExpression(pattern: "^([NSEWLRF])([0-9]+)$")
        let instructions = try input.lines
            .map(regex.match)
            .map(Instruction.init)

        var ship = Ship()
        for instruction in instructions {
            switch instruction.kind {
            case .N: ship.move(.north * instruction.amount)
            case .E: ship.move(.east * instruction.amount)
            case .S: ship.move(.south * instruction.amount)
            case .W: ship.move(.west * instruction.amount)
            case .F: ship.move(ship.facing * instruction.amount)
            case .L: ship.rotate(.left, instruction.amount/90)
            case .R: ship.rotate(.right, instruction.amount/90)
            }
        }

        return Position.origin.manhattenDistance(to: ship.position)
    }

    public static func part2(_ input: Input) throws -> Int {

        let regex = try RegularExpression(pattern: "^([NSEWLRF])([0-9]+)$")
        let instructions = try input.lines
            .map(regex.match)
            .map(Instruction.init)

        var ship = Ship()
        var waypoint = Waypoint()
        for instruction in instructions {
            switch instruction.kind {
            case .N: waypoint.move(.north * instruction.amount)
            case .E: waypoint.move(.east * instruction.amount)
            case .S: waypoint.move(.south * instruction.amount)
            case .W: waypoint.move(.west * instruction.amount)
            case .F: ship.move(Vector(to: waypoint.position) * instruction.amount)
            case .L: waypoint.rotate(.left, instruction.amount/90)
            case .R: waypoint.rotate(.right, instruction.amount/90)
            }
        }

        return Position.origin.manhattenDistance(to: ship.position)
    }
}

extension Day12 {

    fileprivate struct Ship {
        var facing = Vector<Int>.right
        var position = Position.origin
    }

    fileprivate struct Waypoint {
        var position = Position(x: 10, y: 1)
    }

    fileprivate struct Instruction {
        let kind: Kind
        let amount: Int

        enum Kind: String, RawRepresentable {
            case N,S,E,W,L,R,F
        }
    }
}

// MARK: - Actions

extension Day12.Ship {

    mutating func move(_ vector: Vector<Int>) {
        position.move(vector)
    }

    mutating func rotate(_ turn: Turn, _ amount: Int) {
        (1...amount).forEach { _ in facing.rotate(turn) }
    }
}

extension Day12.Waypoint {

    mutating func move(_ vector: Vector<Int>) {
        position.move(vector)
    }

    mutating func rotate(_ turn: Turn, _ amount: Int) {
        (1...amount).forEach { _ in position.rotate(turn) }
    }
}

// MARK: - Parsing

extension Day12.Instruction {

    init(match: RegularExpression.Match) throws {
        amount = try match.integer(at: 1)
        kind = try Kind(match.string(at: 0))
    }
}
