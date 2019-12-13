
import Advent
import Foundation

public struct Day13 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        var computer = IntcodeComputer(input: input)
        try computer.run()
        let output = computer.output

        return output
            .split(length: 3)
            .map(Array.init)
            .map { Tile(x: $0[0], y: $0[1], id: $0[2]) }
            .filter { $0.kind == .block }
            .count
    }
}

struct Tile {
    let kind: Kind
    let position: Position
}

extension Tile {
    enum Kind {
        case empty
        case wall
        case block
        case paddle
        case ball
    }
}

extension Tile {

    init(x: Int, y: Int, id: Int) {
        position = Position(x: x, y: y)
        kind = Kind(id: id)
    }
}

extension Tile.Kind {

    init(id: Int) {
        switch id {
        case 0: self = .empty
        case 1: self = .wall
        case 2: self = .block
        case 3: self = .paddle
        case 4: self = .ball
        default: fatalError()
        }
    }
}
