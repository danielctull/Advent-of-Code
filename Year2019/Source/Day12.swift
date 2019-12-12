
import Advent
import Foundation

public struct Day12 {

    public init() {}

    public func part1(steps: Int, input: Input) throws -> Int {

        let moons = input.lines.map { Moon($0.string) }

        return (1...steps)
            .reduce(moons) { moons, iteration -> [Moon] in
                let newMoons = moons.map { moon in
                    moon.adjustingVelocity(for: moons)
                        .moving()
                }
                return newMoons
            }
            .map { $0.position.sum * $0.velocity.sum }
            .reduce(0, +)
    }
}

struct Moon {
    var position: Position3D
    var velocity: Position3D

    fileprivate init(_ string: String) {
        let numerics = CharacterSet(charactersIn: "-0123456789")
        let numbers = string.split(separator: ",").map {
            $0.trimmingCharacters(in: numerics.inverted)
        }
        let x = Int(numbers[0])!
        let y = Int(numbers[1])!
        let z = Int(numbers[2])!
        position = Position3D(x: x, y: y, z: z)
        velocity = Position3D.origin
    }
}

extension Moon: CustomStringConvertible {
    var description: String { "pos=\(position), vel=\(velocity)" }
}

extension Position3D: CustomStringConvertible {
    public var description: String { "<x=\(x), y=\(y), z=\(z)>" }
}

extension Position3D {
    fileprivate var sum: Int { abs(x) + abs(y) + abs(z) }
}

extension Moon {

    func adjustingVelocity(for otherMoons: [Moon]) -> Moon {
        otherMoons.reduce(into: self) { this, other in

            func offset(this: Int, other: Int) -> Int {
                let base = other - this
                guard base != 0 else { return base }
                return base / abs(base)
            }

            let xOffset = offset(this: this.position.x, other: other.position.x)
            let yOffset = offset(this: this.position.y, other: other.position.y)
            let zOffset = offset(this: this.position.z, other: other.position.z)
            this.velocity += Position3D(x: xOffset, y: yOffset, z: zOffset)
        }
    }

    mutating func move() { position += velocity }

    func moving() -> Moon {
        var moon = self
        moon.move()
        return moon
    }
}
