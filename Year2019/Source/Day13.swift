
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

    var grid = Grid<Day13.Tile>(origin: .bottomLeft)
    var score: Int = -1
    var blocks: [Position] { grid.positions(of: .block) }
    var ball: Position { grid.firstPosition(of: .ball)! }
    var paddle: Position { grid.firstPosition(of: .paddle)! }
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
            default: grid[Position(x: x, y: y)] = try Day13.Tile(values[2])
            }
        }
    }
}

// MARK: - Tile

extension Day13 {

    fileprivate enum Tile: Int {
        case empty = 0
        case wall = 1
        case block = 2
        case paddle = 3
        case ball = 4
    }
}

extension Day13.Tile: RawRepresentable {}

extension Day13.Tile: CustomStringConvertible {

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
        ["Score: \(score)", grid.description].joined(separator: "\n")
    }
}
