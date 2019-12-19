
import Advent
import Foundation

public struct Day19 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        return try Grid(origin: .topLeft, width: 50, height: 50) { position -> Drone in
            var computer = IntcodeComputer(input: input)
            computer.input(position.x)
            computer.input(position.y)
            try computer.run()
            return try Drone(computer.output.last!)
        }
        .positions(of: .pulled)
        .count
    }
}

// MARK: - Drone

extension Day19 {

    enum Drone: Int {
        case stationary = 0
        case pulled = 1
    }
}

extension Day19.Drone: RawRepresentable {}

extension Day19.Drone: CustomStringConvertible {

    var description: String {
        switch self {
        case .stationary: return "."
        case .pulled: return "#"
        }
    }
}
