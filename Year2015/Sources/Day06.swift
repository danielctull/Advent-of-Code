
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day06: Day {

    public static let title = "Probably a Fire Hazard"

    public static func part1(_ input: Input) throws -> Int {

        let isLightOn = try input.lines
            .map(Instruction.init)
            .reduce(.false) { existing, instruction in
                Predicate { position in

                    guard instruction.affects(position) else {
                        return existing(position)
                    }

                    switch instruction.kind {
                    case .off: return false
                    case .on: return true
                    case .toggle: return !existing(position)
                    }
                }
            }

        return (0...999).flatMap { x in
            (0...999).map { y in
                Position2D(x: x, y: y)
            }
        }
        .count(where: isLightOn)
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day06 {

    private struct Instruction {

        enum Kind: String, CaseIterable {
            case on = "turn on"
            case toggle = "toggle"
            case off = "turn off"
        }

        private static let regex = Regex {
            TryCapture {
                ChoiceOf {
                    "turn on"
                    "toggle"
                    "turn off"
                }
            } transform: {
                Kind(rawValue: String($0))
            }
            " "
            TryCapture.integer
            ","
            TryCapture.integer
            " through "
            TryCapture.integer
            ","
            TryCapture.integer
        }

        let kind: Kind
        let start: Position2D<Int>
        let end: Position2D<Int>

        init(string: String) throws {
            let output = try Self.regex.match(in: string).output
            kind = output.1
            start = Position2D(x: output.2, y: output.3)
            end = Position2D(x: output.4, y: output.5)
        }

        func affects(_ position: Position2D<Int>) -> Bool {
            position.x >= start.x &&
            position.x <= end.x &&
            position.y >= start.y &&
            position.y <= end.y
        }
    }
}
