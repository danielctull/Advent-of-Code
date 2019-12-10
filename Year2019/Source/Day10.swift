
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

            let count = asteroids.count(where: { other in
                guard position != other else { return false }
                let line = Line(start: position, end: other)
                let blocker = asteroids.first(where: { line.contains($0) })
                return blocker == nil
            })

            return (position, count)
        }
        .sorted(by: { $0.1 < $1.1 })
        .last!
    }

    public func part2(input: Input) throws -> Int {
        0
    }
}

extension Sequence {

    func count(where predicate: (Element) -> Bool) -> Int {
        var count = 0
        for element in self {
            if predicate(element) {
                count += 1
            }
        }
        return count
    }
}
