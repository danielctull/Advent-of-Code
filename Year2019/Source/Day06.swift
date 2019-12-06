
import Advent
import Foundation

public struct Day06 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let orbits = input
            .lines
            .map { Object(string: $0.string) }
            .group(by: { $0.orbits })

        var indirectOrbits: [String: Int] = [:]
        var workingObjects = [("COM", 0)]

        while let object = workingObjects.first {
            workingObjects.removeFirst()
            indirectOrbits[object.0] = object.1
            if let discovered = orbits[object.0] {
                workingObjects.append(contentsOf: discovered.map {
                    ($0.name, object.1 + 1)
                })
            }
        }

        return indirectOrbits.values.reduce(0, +)
    }

    public func part2(input: Input) throws -> Int {
        0
    }
}

fileprivate struct Object: Equatable, Hashable {

    let name: String
    let orbits: String

    init(string: String) {
        let components = string.components(separatedBy: ")")
        name = components[1]
        orbits = components[0]
    }
}
