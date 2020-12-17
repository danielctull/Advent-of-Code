
import Advent
import Algorithms
import Foundation

public struct Day10 {

    public init() {}

    public func part1(input: Input) -> String {
        return stages(input: input).last?.output ?? ""
    }

    public func part2(input: Input) -> Int {
        return stages(input: input).dropFirst().count
    }

    private func stages(input: Input) -> [[Light]] {

        let lights = input
            .lines
            .map(Light.init)

        return [lights]
            .cycled()
            .accumulating(lights) { previous, _ -> [Light]? in

                let next: [Light] = previous.map {
                    var light = $0
                    light.position.x += light.velocity.x
                    light.position.y += light.velocity.y
                    return light
                }

                let nextSize = next.size
                let previousSize = previous.size
                guard nextSize.x < previousSize.x || nextSize.y < previousSize.y else {
                    return nil
                }

                return next
        }.map { $0 }
    }
}

extension Sequence where Element == Light {

    var size: Position2D<Int> {
        let xs = map { $0.position.x }
        let ys = map { $0.position.y }

        guard xs.count > 0, ys.count > 0 else {
            return Position(x: Int.max, y: Int.max)
        }

        let x = xs.max()! - xs.min()! + 1
        let y = ys.max()! - ys.min()! + 1
        return Position(x: x, y: y)
    }

    var output: String {

        let minX = map { $0.position.x }.min()!
        let minY = map { $0.position.y }.min()!
        let size = self.size

        let xs = minX..<size.x + minX
        let ys = minY..<size.y + minY

        return ys.map { y in

            xs.map { x in

                if contains(where: { $0.position.x == x && $0.position.y == y }) {
                    return "#"
                } else {
                    return "."
                }

            }.reduce("", +)

        }.joined(separator: "\n")
    }
}

struct Light {

    struct Coordinate {
        var x: Int
        var y: Int
    }

    var position: Coordinate
    let velocity: Coordinate
}

extension Light {

    init(_ string: String) {

        let components = string
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "position=", with: "")
            .replacingOccurrences(of: "velocity=", with: "")
            .trimmingCharacters(in: CharacterSet(charactersIn: "><"))
            .components(separatedBy: "><")

        position = Coordinate(components[0])
        velocity = Coordinate(components[1])


    }
}

extension Light.Coordinate {

    init(_ string: String) {
        let components = string.components(separatedBy: ",")
        x = Int(components[0])!
        y = Int(components[1])!
    }
}
