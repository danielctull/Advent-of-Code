
import Advent
import Foundation

public struct Day19 {

    public init() {}

    private func drone(input: Input, position: Position) throws -> Drone {
        var computer = IntcodeComputer(input: input)
        computer.input(position.x)
        computer.input(position.y)
        try computer.run()
        return try Drone(computer.output.last!)
    }

    public func part1(input: Input) throws -> Int {

        try Grid(origin: .topLeft, width: 50, height: 50) { position -> Drone in
            try drone(input: input, position: position)
        }
        .positions(of: .pulled)
        .count
    }

    public func part2(input: Input) throws -> Int {

        func scan(_ position: Position) throws -> (Drone, Bool) {

            let d = try drone(input: input, position: position)
            guard case .pulled = d else { return (.stationary, false) }

            let droneX = try drone(input: input, position: position.offsetting(x: 99, y: 0))
            let droneY = try drone(input: input, position: position.offsetting(x: 0, y: 99))
            return (.pulled, droneX == .pulled && droneY == .pulled)
        }

        let start = try Grid(origin: .topLeft, width: 10, height: 10) { position -> Drone in
                try drone(input: input, position: position)
            }
            .positions(of: .pulled)
            .sorted(by: { lhs, rhs in rhs.x < lhs.x && lhs.y < rhs.y })
            .first!

        var positions = [start]
        var entrances = Set<Int>()

        while let position = positions.first {
            positions.removeFirst()

            let result = try scan(position)

            guard !result.1 else { return position.x * 10_000 + position.y }

            switch (result.0, entrances.contains(position.x)) {

            case (.pulled, false):
                entrances.insert(position.x)
                positions.insert(position.offsetting(x: 0, y: 1), at: 0)
                positions.append(position.offsetting(x: 1, y: 0))

            case (.pulled, true):
                positions.append(position.offsetting(x: 0, y: 1))

            case (.stationary, false):
                positions.append(position.offsetting(x: 0, y: 1))

            case (.stationary, true):
                continue
            }
        }

        return 0
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
