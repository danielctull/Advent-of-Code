
import Advent
import Algorithms
import Foundation

public struct Day06 {

    public init() {}

    public func part1(input: Input) -> Int {

        let coordinates = input
            .lines
            .map(Position2D<Int>.init)

        let xs = coordinates.map { $0.x }
        let ys = coordinates.map { $0.y }

        let minX = xs.min()!
        let maxX = xs.max()!

        let minY = ys.min()!
        let maxY = ys.max()!

        let x = ((minX-1)...(maxX+1)).cycled()
        let y = ((minY-1)...(maxY+1)).repeatingElements(maxX - minX + 3)

        var ignored: Set<Position2D<Int>> = []

        let winningCoordinates: [Position2D<Int>] = zip(x, y)
            .map(Position2D.init)
            .reduce(into: []) { result, location in

            let distances = coordinates.map {
                ($0, $0.manhattenDistance(to: location))
            }

            let closest = distances.min { $0.1 < $1.1 }!

            // Make sure there is only one coordinate that shares this closeness
            guard distances.map({ $0.1 }).countByElement[closest.1] == 1 else {
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
            .countByElement
            .values
            .max() ?? 0
    }

    public func part2(input: Input, size: Int) -> Int {

        let coordinates = input
            .lines
            .map(Position2D.init)

        let xs = coordinates.map { $0.x }
        let ys = coordinates.map { $0.y }

        let minX = xs.min()!
        let maxX = xs.max()!

        let minY = ys.min()!
        let maxY = ys.max()!

        let x = ((minX-1)...(maxX+1)).cycled()
        let y = ((minY-1)...(maxY+1)).repeatingElements(maxX - minX + 3)

        return zip(x, y)
            .map(Position2D.init)
            .map { location in

                return coordinates.reduce(into: 0) { result, coordinate in
                    result += coordinate.manhattenDistance(to: location)
                }
            }
            .filter { $0 < size }
            .count
    }
}

extension Position2D where Scalar == Int {

    fileprivate init(_ string: String) {

        let components = string
            .replacingOccurrences(of: " ", with: "")
            .components(separatedBy: ",")

        self.init(x: Int(components[0])!, y: Int(components[1])!)
    }
}
