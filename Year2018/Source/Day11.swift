
import Advent
import Foundation

public struct Day11 {

    public init() {}

    public func part1(input: Input) -> String {

        let serial = input.lines.map { Int($0.string)! }.first!
        let row = (1...300).lookingAhead(3)

        return product(row, row)
            .map { xs, ys -> (Coordinate, Int) in

                let power = product(xs, ys)
                    .map(Coordinate.init)
                    .map { $0.power(serial: serial) }
                    .reduce(0, +)

                let topLeft = Coordinate(x: xs.min()!, y: ys.min()!)
                return (topLeft, power)

            }
            .max { $0.1 < $1.1 }
            .map { "\($0.0.x),\($0.0.y)" } ?? ""
    }

    public func part2(input: Input) -> String {

        let serial = input.lines.map { Int($0.string)! }.first!
        let row = (1...300)

        print("Calculating Power Grid")

        let powerGrid: [[Int]] = row.map { y in
            return row.map { x in
                let coordinate = Coordinate(x: x, y: y)
                return coordinate.power(serial: serial)
            }
        }

        return row
            .flatMap { size in
                product(row.lookingAhead(size), row.lookingAhead(size)).flatMap { xs, ys in
                    product(xs, ys).map { x, y -> (Coordinate, Int, Int) in
                        if x == 1 && y == 1 { print("Starting size", size) }
                        return (Coordinate(x: x, y: y), size, powerGrid[x-1][y-1])
                    }
                }
            }
            .max { $0.2 < $1.2 }
            .map { "\($0.0.x),\($0.0.y),\($0.1)" }!
    }
}

extension Day11 {

    fileprivate struct Coordinate {
        let x: Int
        let y: Int
    }
}

extension Day11.Coordinate {

    func power(serial: Int) -> Int {
        let rackID = x + 10
        var power = rackID * y
        power += serial
        power *= rackID
        power = (power / 100) % 10
        power -= 5
        return power
    }
}
