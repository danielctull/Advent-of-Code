
import Advent
import Foundation

public struct Day11 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        var robot = RobotPainter()
        var computer = IntcodeComputer(input: input)

        while !computer.isHalted {
            computer.input(robot.input)
            try computer.run()
            robot.paint(value: computer.paint)
            robot.move(value: computer.move)
        }

        return robot.panels.tiles.count
    }

    public func part2(input: Input) throws -> String {

        var robot = RobotPainter(starting: .white)
        var computer = IntcodeComputer(input: input)

        while !computer.isHalted {
            computer.input(robot.input)
            try computer.run()
            robot.paint(value: computer.paint)
            robot.move(value: computer.move)
        }

        return robot.state(showingRobot: false)
    }
}

extension IntcodeComputer {
    fileprivate var paint: Int { output[output.count - 2] }
    fileprivate var move: Int { output[output.count - 1] }
}

extension Day11 {

    public struct RobotPainter {
        var panels: Grid<Position2D<Int>, Day11.Tile>
        var direction = Vector2D<Int>.up
        var position = Position2D<Int>.origin
    }
}

extension Day11.RobotPainter {

    public init(starting: Day11.Tile = .black) {
        panels = Grid(tiles: [.origin: starting])
    }

    public mutating func move(value: Int) {
        let turn: Transform2D<Int> = value == 0 ? .rotate270 : .rotate90
        direction = direction.transforming(turn)
        position += direction
    }

    public mutating func paint(value: Int) {
        let panel = value == 0 ? Day11.Tile.black : .white
        panels[position] = panel
    }

    fileprivate var input: Int {
        switch panels[position] {
        case .white: return 1
        default: return 0
        }
    }

    public func state(showingRobot: Bool = true) -> String {

        var panels = self.panels
        panels.empty = "."

        if showingRobot {
            panels[position] = .robot(direction)
        }

        return panels.description
    }
}

// MARK: - Tile

extension Day11 {

    public enum Tile {
        case black
        case white
        case robot(Vector2D<Int>)
    }
}

extension Day11.Tile: CustomStringConvertible {

    public var description: String {
        switch self {
        case .black: return "."
        case .white: return "#"
        case .robot(.down): return "v"
        case .robot(.up): return "^"
        case .robot(.left): return "<"
        case .robot(.right): return ">"
        default: fatalError()
        }
    }
}
