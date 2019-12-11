
import Advent
import Foundation

public struct Day11 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let code = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        var robot = RobotPainter()
        var computer = IntcodeComputer(code: code)

        while !computer.isHalted {
            let input = robot.currentPanel == .black ? 0 : 1
            computer.input(input)
            try computer.run()
            robot.paint(value: computer.paint)
            robot.move(value: computer.move)
        }

        return robot.panels.count
    }

    public func part2(input: Input) throws -> Int {
        0
    }
}

extension IntcodeComputer {
    var paint: Int { output[output.count - 2] }
    var move: Int { output[output.count - 1] }
}

public enum Panel {
    case white, black
}

public struct RobotPainter {
    var panels = [Position.origin: Panel.black]
    var direction = Direction.up
    var position = Position.origin

    public init() {}

    public mutating func move(value: Int) {
        let turn = value == 0 ? Turn.left : .right
        direction = direction.perform(turn)
        position = position.move(Move(direction: direction, amount: 1))
    }

    public mutating func paint(value: Int) {
        let panel = value == 0 ? Panel.black : .white
        panels[position] = panel
    }
}

extension RobotPainter {

    public var currentPanel: Panel { panels[position] ?? .black }

    public func state(showingRobot: Bool = true) -> String {
        var positions = Array(panels.keys)
        positions.append(position)
        let maxX = positions.map { $0.x }.max() ?? 0
        let minX = positions.map { $0.x }.min() ?? 0
        let maxY = positions.map { $0.y }.max() ?? 0
        let minY = positions.map { $0.y }.min() ?? 0

        let countX = maxX - minX + 1
        let countY = maxY - minY + 1
        var output = Array(repeating: Array(repeating: Character("."), count: countX), count: countY)

        for panel in panels {
            let position = panel.key.offsetting(x: -minX, y: -minY)
            output[position.y][position.x] = panel.value == .black ? "." : "#"
        }

        if showingRobot {
            let value: Character
            switch direction {
            case .down: value = "v"
            case .up: value = "^"
            case .left: value = "<"
            case .right: value = ">"
            }
            let robot = position.offsetting(x: -minX, y: -minY)
            output[robot.y][robot.x] = value
        }

        return output.reversed().map { String($0) }.joined(separator: "\n")
    }
}
