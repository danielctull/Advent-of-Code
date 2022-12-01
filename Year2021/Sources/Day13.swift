
import Advent
import Algorithms
import Foundation

public enum Day13 {

    public static let title = "Transparent Origami"

    public static func part1(_ input: Input) throws -> Int {
        let segments = input.lines.split(whereSeparator: \.isEmpty)
        let positions = try Set(positions: segments[0])
        let instructions = try Array(instructions: segments[1])
        return positions
            .apply(instruction: instructions[0])
            .count
    }

    public static func part2(_ input: Input) throws -> [String] {
        let segments = input.lines.split(whereSeparator: \.isEmpty)
        let positions = try Set(positions: segments[0])
        let instructions = try Array(instructions: segments[1])
        let result = instructions.reduce(positions) { positions, instruction in
            positions.apply(instruction: instruction)
        }
        return try result.output
    }
}

extension Set where Element == Position2D<Int> {

    fileprivate init<Lines>(
        positions: Lines
    ) throws where Lines: Collection, Lines.Element == String {
        self = try Set(
            positions.map { string in
                let split = string.split(separator: ",")
                return try Position2D(
                    x: Int(split.first.unwrapped),
                    y: Int(split.last.unwrapped))
            }
        )
    }

    fileprivate func apply(instruction: Day13.Instruction) -> Self {

        Set(map { position in
            switch instruction {
            case let .x(x) where x < position.x:
                return Position2D(x: abs(position.x - 2 * x), y: position.y)
            case let .y(y) where y < position.y:
                return Position2D(x: position.x, y: abs(position.y - 2 * y))
            default:
                return position
            }
        })
    }

    fileprivate var output: [String] {
        get throws {
            let maxX = try map(\.x).max + 1
            let maxY = try map(\.y).max + 1
            var output = Array(
                repeating: Array(repeating: ".", count: maxX),
                count: maxY)
            for position in self {
                output[position.y][position.x] = "#"
            }
            return  output.map { $0.joined() }
        }
    }
}

extension Array where Element == Day13.Instruction {

    fileprivate init<Lines>(
        instructions: Lines
    ) throws where Lines: Collection, Lines.Element == String {
        let regex = try RegularExpression(pattern: #"fold along ([x|y])=(\d+)"#)
        self = try instructions
            .map(regex.match)
            .map { match in
                let value = try match.integer(at: 1)
                switch try match.string(at: 0) {
                case "x": return Element.x(value)
                case "y": return Element.y(value)
                case let string: throw UnexpectedRawValue(rawValue: string)
                }
            }
    }
}

extension Day13 {

    enum Instruction {
        case x(Int)
        case y(Int)
    }
}
