
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day02: Day {

    public static let title = "Cube Conundrum"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map(Game.init)
            .filter { game in
                game.draws.allSatisfy { draw in
                    draw.red <= 12 &&
                    draw.green <= 13 &&
                    draw.blue <= 14
                }
            }
            .map(\.number)
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .map(Game.init)
            .map { game in
                let red = try game.draws.map(\.red).max
                let green = try game.draws.map(\.green).max
                let blue = try game.draws.map(\.blue).max
                return red * green * blue
            }
            .sum
    }
}

private struct Game {
    let number: Int
    let draws: [Draw]
}

private struct Draw {
    let red: Int
    let green: Int
    let blue: Int
}

private enum Color: String {
    case red
    case green
    case blue
}

extension Game {

    init(_ string: String) throws {
        let output = try string.firstMatch(of: game).unwrapped.output
        self.init(number: output.1, draws: output.2)
    }
}

fileprivate let game = Regex {
    "Game "
    TryCapture.integer
    ":"
    Capture {
        List {
            Capture.draw
            Optionally(";")
        }
    }
}

extension Capture<(Substring, Draw)> {
    fileprivate static let draw = Capture {
        Map {
            Reverse {
                " "
                TryCapture.integer
                " "
                TryCapture.color
                Optionally(",")
            }
        }
    } transform: { draw in
        Draw(
            red: draw[.red, default: 0],
            green: draw[.green, default: 0],
            blue: draw[.blue, default: 0])
    }
}

extension TryCapture<(Substring, Color)> {
    fileprivate static let color = TryCapture {
        ChoiceOf {
            "red"
            "green"
            "blue"
        }
    } transform: {
        Color(rawValue: String($0))
    }
}
