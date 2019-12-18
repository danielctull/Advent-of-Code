
import Advent
import Foundation

public struct Day13 {

    public init() {}

    public func part1(input: Input) throws -> Int {
        let computer = IntcodeComputer(input: input)
        let game = try BlockGame(computer: computer)
        return game.blocks.count
    }

    public func part2(input: Input) throws -> Int {
        let computer = IntcodeComputer(input: input)
        var game = try BlockGame(computer: computer, credits: 2)
        while !game.computer.isHalted, game.blocks.count > 0 {
            switch game.ball.x - game.paddle.x {
            case 0: try game.move(.neutral)
            case 0...: try game.move(.right)
            case ...0: try game.move(.left)
            default: fatalError()
            }
        }
        return game.score
    }
}

fileprivate struct BlockGame {

    var computer: IntcodeComputer
    init(computer: IntcodeComputer, credits: Int = -1) throws {
        self.computer = computer
        if credits >= 0 { self.computer.code[0] = credits }
        try run()
    }

    var tiles: [Position: Tile] = [:]
    var score: Int = -1
    var blocks: [Position] { tiles.filter { $0.value == .block }.map { $0.key } }
    var ball: Position { tiles.first(where: { $0.value == .ball })!.key }
    var paddle: Position { tiles.first(where: { $0.value == .paddle })!.key }
}

extension BlockGame {

    enum Move {
        case neutral
        case left
        case right
    }

    mutating func move(_ move: Move) throws {

        guard !computer.isHalted else { return }

        switch move {
        case .neutral: computer.input(0)
        case .left: computer.input(-1)
        case .right: computer.input(1)
        }

        try run()
    }

    mutating func run() throws {

        guard !computer.isHalted else { return }

        try computer.run()
        let output = computer.nextOutput().split(length: 3).map(Array.init)

        for values in output {
            let x = values[0]
            let y = values[1]
            switch (x, y) {
            case (-1, 0): self.score = values[2]
            default: tiles[Position(x: x, y: y)] = Tile(id: values[2])
            }
        }
    }
}

fileprivate enum Tile {
    case empty
    case wall
    case block
    case paddle
    case ball
}

extension Tile {

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

extension Tile: CustomStringConvertible {

    var description: String {
        switch self {
        case .empty: return " "
        case .wall: return "#"
        case .block: return "*"
        case .paddle: return "–"
        case .ball: return "o"
        }
    }
}

extension BlockGame: CustomStringConvertible {

    var description: String {
        let maxX = tiles.keys.map { $0.x }.max()! + 1
        let maxY = tiles.keys.map { $0.y }.max()! + 1
        var output = Array(repeating: Array(repeating: " ", count: maxX), count: maxY)
        for tile in tiles {
            output[tile.key.y][tile.key.x] = String(describing: tile.value)
        }

        return [
            "Score: \(score)",
            output.map { $0.joined() }.joined(separator: "\n")
        ].joined(separator: "\n")
    }
}
