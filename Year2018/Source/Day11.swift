
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
        let totalSize = 300
        let grid = 1...300

        let powerGrid = grid.map { x -> [Int] in
            grid.map { y in
                let coordinate = Coordinate(x: x, y: y)
                return coordinate.power(serial: serial)
            }
        }

        let firstRow = Array(repeating: 0, count: totalSize + 1)
        let accumulatingPowerGrid = powerGrid.accumulating(firstRow) { result, xs in
            zip(result, xs.accumulating(0, +)).map(+)
        }.map { $0 }

        // ^ This creates an accumulating array of power values:
        //
        // 1   2   3   4   5
        // 1   2   3   4   5
        // 1   2   3   4   5
        // 1   2   3   4   5
        // 1   2   3   4   5
        //
        // becomes
        //
        // 1   3   6  10  15
        // 1   3   6  10  15
        // 1   3   6  10  15
        // 1   3   6  10  15
        // 1   3   6  10  15
        //
        // becomes
        //
        // 0   0   0   0   0   0
        // 0   1   3   6  10  15
        // 0   2   6  12  20  30
        // 0   3   9  18  30  45
        // 0   4  12  24  40  60
        // 0   5  18  30  50  75
        //
        // With extra zeros added when x=0 or y=0. For a square with coordinate
        // x,y and size the result is the sum of the values at x+size-1,y+size-1
        // and x-1,y-1 subtracting the values at x-1,y+size-1 and y+size-1,x-1.
        //
        // For example when x=2,y=3,size=3 the calculation is 50+2-5-20 = 27
        // In the original grid we can see that 2+3+4+2+3+4+2+3+4 is indeed 27.

        struct Answer {
            let coordinate: Coordinate
            let size: Int
            let power: Int
        }

        var answer = Answer(coordinate: Coordinate(x: .min, y: .min), size: .min, power: .min)

        grid.forEach { size in
            (0..<(totalSize - size)).forEach { x in
                (0..<(totalSize - size)).forEach { y in

                    let power = accumulatingPowerGrid[x + size][y + size]
                        + accumulatingPowerGrid[x][y]
                        - accumulatingPowerGrid[x][y + size]
                        - accumulatingPowerGrid[x + size][y]

                    if power > answer.power {
                        answer = Answer(coordinate: Coordinate(x: x + 1, y: y + 1), size: size, power: power)
                    }
                }
            }
        }

        return "\(answer.coordinate.x),\(answer.coordinate.y),\(answer.size)"
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
