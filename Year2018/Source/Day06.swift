
import Advent
import Foundation

public struct Day06 {

    public init() {}

    public func part1(input: Input) -> Int {

        let coordinates = input
            .lines
            .map { $0.string }
            .map(Coordinate.init)

        let xs = coordinates.map { $0.x }
        let ys = coordinates.map { $0.y }

        let minX = xs.min()!
        let maxX = xs.max()!

        let minY = ys.min()!
        let maxY = ys.max()!

        let x = ((minX-1)...(maxX+1)).repeating
        let y = ((minY-1)...(maxY+1)).repeatingElements(maxX - minX + 3)

        var ignored: Set<Coordinate> = []

        let winningCoordinates: [Coordinate] = zip(x, y)
            .map(Coordinate.init)
            .reduce(into: []) { result, location in

            let distances = coordinates.map { ($0, $0.distance(to: location)) }

            let closest = distances.min { $0.1 < $1.1 }!

            // Make sure there is only one coordinate that shares this closeness
            guard distances.map({ $0.1 }).countByElements[closest.1] == 1 else {
                return
            }

            guard
                location.x >= minX,
                location.x <= maxX,
                location.y >= minY,
                location.y <= maxY
            else {
                ignored.insert(closest.0)
                return
            }

            result.append(closest.0)
        }

        return winningCoordinates
            .filter { !ignored.contains($0) }
            .countByElements
            .values
            .max() ?? 0
    }

    public func part2(input: Input, size: Int) -> Int {

        let coordinates = input
            .lines
            .map { $0.string }
            .map(Coordinate.init)

        let xs = coordinates.map { $0.x }
        let ys = coordinates.map { $0.y }

        let minX = xs.min()!
        let maxX = xs.max()!

        let minY = ys.min()!
        let maxY = ys.max()!

        let x = ((minX-1)...(maxX+1)).repeating
        let y = ((minY-1)...(maxY+1)).repeatingElements(maxX - minX + 3)

        return zip(x, y)
            .map(Coordinate.init)
            .map { location in

                return coordinates.reduce(into: 0) { result, coordinate in
                    result += coordinate.distance(to: location)
                }
            }
            .filter { $0 < size }
            .count
    }
}


struct Coordinate {
    let x: Int
    let y: Int
}

extension Coordinate {

    init(_ string: String) {

        let components = string
            .replacingOccurrences(of: " ", with: "")
            .components(separatedBy: ",")

        x = Int(components[0])!
        y = Int(components[1])!
    }
}

extension Coordinate: Hashable {}

extension Coordinate {

    func distance(to other: Coordinate) -> Int {
        return abs(other.x - x) + abs(other.y - y)
    }
}
