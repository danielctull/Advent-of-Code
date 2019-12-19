
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

            switch (try drone(input: input, position: position), entrances.contains(position.x)) {

            case (.pulled, false):
                entrances.insert(position.x)
                positions.append(position.offsetting(x: 1, y: 0))
                guard try drone(input: input, position: position.offsetting(x: 0, y: 99)) == .pulled else { continue }
                positions.insert(position.offsetting(x: 0, y: 1), at: 0)

            case (.pulled, true):
                positions.append(position.offsetting(x: 0, y: 1))

            case (.stationary, false):
                positions.append(position.offsetting(x: 0, y: 1))
                continue

            case (.stationary, true):
                continue
            }

            guard try drone(input: input, position: position.offsetting(x: 99, y:  0)) == .pulled else { continue }
            guard try drone(input: input, position: position.offsetting(x:  0, y: 99)) == .pulled else { continue }

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
