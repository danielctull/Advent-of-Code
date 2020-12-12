
import Advent
import Foundation

public enum Day12 {

    public static func part1(_ input: Input) throws -> Int {

        let regex = try RegularExpression(pattern: "^([NSEWLRF])([0-9]+)$")
        let ship = try input.lines
            .map(regex.match)
            .map(Instruction.init)
            .reduce(into: Ship()) { ship, instruction in ship.perform(instruction) }

        return Position.origin.manhattenDistance(to: ship.position)
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day12.Ship {

    mutating func move(_ direction: Direction, amount: Int) {
        position = position.move(Move(direction: direction, amount: amount))
    }

    mutating func rotate(_ turn: Turn, amount: Int) {
        (1...amount).forEach { _ in facing = facing.rotate(turn) }
    }

    mutating func perform(_ instruction: Day12.Instruction) {
        switch instruction.kind {
        case .N: move(.up, amount: instruction.amount)
        case .E: move(.right, amount: instruction.amount)
        case .S: move(.down, amount: instruction.amount)
        case .W: move(.left, amount: instruction.amount)
        case .F: move(facing, amount: instruction.amount)
        case .L: rotate(.left, amount: instruction.amount/90)
        case .R: rotate(.right, amount: instruction.amount/90)
        }
    }
}

extension Day12 {

    fileprivate struct Ship {
        var facing = Direction.right
        var position = Position.origin
    }

    fileprivate struct Instruction {
        let kind: Kind
        let amount: Int

        enum Kind: String, RawRepresentable {
            case N // means to move north by the given value.
            case S // means to move south by the given value.
            case E // means to move east by the given value.
            case W // means to move west by the given value.
            case L // means to turn left the given number of degrees.
            case R // means to turn right the given number of degrees.
            case F // means to move forward by the given value in the direction the ship is currently facing.
        }
    }
}

extension Day12.Instruction {

    init(match: RegularExpression.Match) throws {
        amount = try match.integer(at: 1)
        kind = try Kind(try match.string(at: 0))
    }
}
