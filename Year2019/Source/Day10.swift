
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
            .map { $0.string }
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

    struct Angle {
        let start: Position
        let end: Position

        var value: Double {
            let opposite = Double(end.x - start.x)
            let adjacent = Double(end.y - start.y)
            let angle = atan2(adjacent, opposite)
            // Angles start from y = 0 so this bumps 90° and makes all values
            // between 0 and 2π.
            return (angle + 2.5 * .pi).truncatingRemainder(dividingBy: 2 * .pi)
        }
    }

    public func part2(input: Input) throws -> Int {

        let max = maximumVisibleAsteroids(for: input)
        let position = max.0
        let asteroids = max.1

        let sortedAsteroids = asteroids
            .map { asteroid -> (Position, Double) in
                let angle = Angle(start: position, end: asteroid)
                return (asteroid, angle.value)
            }
            .sorted { $0.1 < $1.1 }

        let asteroidPosition = sortedAsteroids[199].0
        return asteroidPosition.x * 100 + asteroidPosition.y
    }
}
