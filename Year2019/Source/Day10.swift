
import Advent
import Foundation

public struct Day10 {

    public struct Line {
        let start: Position
        let end: Position
        
        public init(start: Position, end: Position) {
            self.start = start
            self.end = end
        }

        private func gradient(from start: Position, to end: Position) -> Double {
            let denominator = end.y - start.y
            guard denominator != 0 else { return .greatestFiniteMagnitude }
            return Double(end.x - start.x) / Double(denominator)
        }

        public func contains(_ position: Position) -> Bool {
            guard
                position != start,
                position != end,
                min(start.x, end.x) <= position.x,
                min(start.y, end.y) <= position.y,
                position.x <= max(start.x, end.x),
                position.y <= max(start.y, end.y)
            else {
                return false
            }
            return gradient(from: start, to: position)
                == gradient(from: position, to: end)
        }
    }

    public init() {}

    public func part1(input: Input) throws -> (Position, Int) {
        let max = maximumVisibleAsteroids(for: input)
        return (max.0, max.1.count)
    }

    private func maximumVisibleAsteroids(for input: Input) -> (Position, [Position]) {

        let asteroids = input
            .lines
            .enumerated()
            .flatMap { y, string in
                string.enumerated().compactMap { x, character -> Position? in
                    character == "#" ? Position(x: x, y: y) : nil
                }
            }

        return asteroids.map { position in

            let visible = asteroids.filter { other in
                guard position != other else { return false }
                let line = Line(start: position, end: other)
                let blocker = asteroids.first(where: { line.contains($0) })
                return blocker == nil
            }

            return (position, visible)
        }
        .sorted(by: { $0.1.count < $1.1.count })
        .last!
    }

    public func part2(input: Input) throws -> Int {

        let max = maximumVisibleAsteroids(for: input)
        let position = max.0
        let asteroids = max.1

        let sortedAsteroids = asteroids
            .map { asteroid -> (Position, Angle) in
                let angle = Angle(start: position, end: asteroid)
                // Angles start from the 3 o'clock position so add 90° such that
                // 12 o'clock values become "zero".
                return (asteroid, angle + Angle(degrees: 90))
            }
            .sorted { $0.1 < $1.1 }

        let asteroidPosition = sortedAsteroids[199].0
        return asteroidPosition.x * 100 + asteroidPosition.y
    }
}
