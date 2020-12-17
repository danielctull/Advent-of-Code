
import Advent
import Foundation

public struct Day19 {

    public init() {}

    private func drone(input: Input, position: Position2D<Int>) throws -> Drone {
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

        var drones: [Position2D<Int>: Drone] = [:]
        func drone(at position: Position2D<Int>) throws -> Drone {
            if let drone = drones[position] { return drone }
            let drone = try self.drone(input: input, position: position)
            drones[position] = drone
            return drone
        }

        let start = try Grid(origin: .topLeft, width: 10, height: 10, tile: drone(at:))
            .positions(of: .pulled)
            .sorted(by: { lhs, rhs in rhs.x < lhs.x && lhs.y < rhs.y })
            .first!

        var positions = [start]
        var entrances = Set<Int>()

        while let position = positions.first {
            positions.removeFirst()

            switch (try drone(at: position), entrances.contains(position.x)) {

            // We've not hit the top of the beam yet.
            case (.pulled, false):
                entrances.insert(position.x)
                positions.append(position + Vector2D(x: 1, y: 0))
                guard try drone(at: position + Vector2D(x: 0, y: 99)) == .pulled else { continue }
                positions.insert(position + Vector2D(x: 0, y: 1), at: 0)

            // We're inspecting the beam.
            case (.pulled, true):
                positions.append(position + Vector2D(x: 0, y: 1))

            // We've not hit the beam yet.
            case (.stationary, false):
                positions.append(position + Vector2D(x: 0, y: 1))
                continue

            // We've gone beyond the scope of the beam.
            case (.stationary, true):
                continue
            }

            // If the drones at x+99 and y+99 are being pulled, then this is
            // the top left of the 100x100 square.
            guard try drone(at: position + Vector2D(x: 99, y:  0)) == .pulled else { continue }
            guard try drone(at: position + Vector2D(x:  0, y: 99)) == .pulled else { continue }

            return position.x * 10_000 + position.y
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
