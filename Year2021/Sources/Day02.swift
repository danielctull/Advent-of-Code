
import Advent
import Algorithms
import Foundation

public enum Day02: Day {

    public static let title = "Dive!"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map(Command.init)
            .reduce(into: Location()) { location, command in
                switch command {
                case .up(let amount): location.depth -= amount
                case .down(let amount): location.depth += amount
                case .forward(let amount): location.horizontal += amount
                }
            }
            .result
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day02 {

    fileprivate enum Command {
        case up(Int)
        case down(Int)
        case forward(Int)
    }

    private struct Location {
        var depth: Int = 0
        var horizontal: Int = 0
        var result: Int { depth * horizontal }
    }
}

extension Day02.Command {

    init(_ string: String) throws {
        let components = string.split(separator: " ")
        let name = try components.first.unwrapped()
        let value = try Int(components.last.unwrapped())
        switch name {
        case "up": self = .up(value)
        case "down": self = .down(value)
        case "forward": self = .forward(value)
        default: throw UnexpectedRawValue(rawValue: name)
        }
    }
}
