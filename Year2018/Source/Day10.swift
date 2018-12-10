
import Advent
import Foundation

public struct Day10 {

    public init() {}

    public func part1(input: Input) -> String {

        var lights = input
            .lines
            .map { $0.string }
            .map(Light.init)

        func calculateSize(of lights: [Light]) -> Coordinate {
            let xs = lights.map { $0.position.x }
            let ys = lights.map { $0.position.y }
            let x = xs.max()! - xs.min()! + 1
            let y = ys.max()! - ys.min()! + 1
            return Coordinate(x: x, y: y)
        }

        var previousSize = Coordinate(x: Int.max, y: Int.max)
        var currentSize = calculateSize(of: lights)
        var previousLights = lights
        
        while currentSize.x < previousSize.x || currentSize.y < previousSize.y {

            previousLights = lights
            lights = lights.map {
                var light = $0
                light.position.x += light.velocity.x
                light.position.y += light.velocity.y
                return light
            }

            previousSize = currentSize
            currentSize = calculateSize(of: lights)
        }

        let x = previousLights.map { $0.position.x }.min()!
        let y = previousLights.map { $0.position.y }.min()!
        let size = calculateSize(of: previousLights)

        let xs = x..<size.x + x
        let ys = y..<size.y + y

        let result = ys.map { y in

            xs.map { x in

                if previousLights.contains(where: { $0.position.x == x && $0.position.y == y }) {
                    return "#"
                } else {
                    return "."
                }

            }.reduce("", +)

        }.joined(separator: "\n")

//        print(result)

        return result
    }

    public func part2(input: Input) -> Int {
        return 0
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
