
import Advent
import Foundation

public struct Day06 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        input
            .lines
            .map(Object.init)
            .indirectOrbits
            .values
            .reduce(0, +)
    }

    public func part2(input: Input) throws -> Int {

        let objects = input
            .lines
            .map(Object.init)

        let youPath = objects.orbitPath(for: "YOU")
        let santaPath = objects.orbitPath(for: "SAN")

        let shared = youPath.first(where: { santaPath.contains($0) })!

        let indirectOrbits = objects.indirectOrbits
        let youValue = indirectOrbits["YOU"]!
        let santaValue = indirectOrbits["SAN"]!
        let sharedValue = indirectOrbits[shared]!

        return (youValue - sharedValue - 1) + (santaValue - sharedValue - 1)
    }
}

extension Array where Element == Object {

    var indirectOrbits: [String: Int] {

        let orbits = group(by: { $0.orbits })
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

        return indirectOrbits
    }

    func orbitPath(for objectName: String) -> [String] {
        let objectsByName = self.group(by: { $0.name })
        var name = objectName
        var result = [objectName]
        while let object = objectsByName[name]?.first {
            name = object.orbits
            result.append(name)
        }
        return result
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
