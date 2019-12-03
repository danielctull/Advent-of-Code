
import Advent
import Foundation

public struct Day03 {

    public init() {}

    public func part1(input: Input) -> Int {

        let moves = input
            .lines
            .map(Array.init(moves:))

        return moves[0].positions
            .intersection(moves[1].positions)
            .map { $0.manhattenDistance(to: .origin) }
            .sorted()
            .first ?? 0
    }
}

extension Array where Element == Move {

    fileprivate init(moves: Input.Line) {
        self = moves
            .string
            .components(separatedBy: ",")
            .map(Move.init)
    }


    fileprivate var positions: Set<Position> {

        let result = accumulating([Position.origin]) {
                    (positions, move) -> [Position] in
                    move.positions(from: positions.last!)
                }
                .flatMap { $0 }
                .dropFirst()

        return Set(result)
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
