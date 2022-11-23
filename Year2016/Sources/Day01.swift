
import Advent
import Algorithms
import Foundation

public enum Day01: Day {

    public static let title = "No Time for a Taxicab"

    public static func part1(_ input: Input) throws -> Int {

        let instructions = try Array(instructions: input)
        var heading = Vector2D<Int>.north
        var position = Position2D<Int>.origin
        for instruction in instructions {
            heading.transform(instruction.turn)
            position += heading * instruction.amount
        }

        return position.manhattenDistance(to: .origin)
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day01 {

    fileprivate struct Instruction {
        let turn: Transform2D<Int>
        let amount: Int

        init<S: StringProtocol>(string: S) throws {
            turn = try Transform2D(character: string.first.unwrapped)
            amount = try Int(string.dropFirst())
        }
    }
}

extension Transform2D<Int> {

    fileprivate init(character: Character) throws {
        switch character {
        case "L": self = .rotate270
        case "R": self = .rotate90
        default: throw UnexpectedRawValue(rawValue: character)
        }
    }
}

extension Array<Day01.Instruction> {

    fileprivate init(instructions input: Input) throws {
        self = try input.lines
            .flatMap { $0.split(separator: ", ") }
            .map(String.init)
            .map(Day01.Instruction.init)
    }
}
