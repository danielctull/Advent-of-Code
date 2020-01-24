
import Advent
import Foundation

public struct Day03 {

    public init() {}

    public func part1(input: Input) -> Int {

        let moves = input
            .lines
            .map(Array.init(moves:))

        return Set(moves[0].positions)
            .intersection(Set(moves[1].positions))
            .map { $0.manhattenDistance(to: .origin) }
            .sorted()
            .first ?? 0
    }

    public func part2(input: Input) -> Int {

         let moves = input
             .lines
             .map(Array.init(moves:))

        let positions1 = moves[0].positions
        let positions2 = moves[1].positions
        let intersections = Set(positions1).intersection(Set(positions2))

        let distances1 = positions1.distances(for: intersections)
        let distances2 = positions2.distances(for: intersections)

        return distances1
            .map { distances2[$0.key]! + $0.value }
            .sorted()
            .first ?? Int.max
     }
}

extension Array where Element == Position {

    func distances(for intersections: Set<Position>) -> [Position: Int] {

        enumerated()
            .filter { intersections.contains($0.element) }
            .group(by: { $0.element })
            .mapValues { $0.reduce(Int.max) { Swift.min($0, $1.offset + 1) } }
    }
}

extension Array where Element == Move {

    fileprivate init(moves: String) {
        self = moves
            .components(separatedBy: ",")
            .map(Move.init)
    }


    fileprivate var positions: [Position] {

        scan([Position.origin]) { positions, move -> [Position] in
            move.positions(from: positions.last!)
        }
        .flatMap { $0 }
    }
}

extension Move {

    fileprivate init(_ inString: String) {
        var string = inString
        let first = string.removeFirst()

        guard let amount = Int(string) else { fatalError() }

        let direction: Direction
        switch first {
        case "U": direction = .up
        case "D": direction = .down
        case "L": direction = .left
        case "R": direction = .right
        default: fatalError()
        }

        self.init(direction: direction, amount: amount)
    }

    fileprivate func positions(from start: Position) -> [Position] {
        (1...amount).map { amount in
            let move = Move(direction: direction, amount: amount)
            return start.move(move)
        }
    }
}
