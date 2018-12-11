
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

    public func part2(input: Input) -> Int {
        return 0
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
