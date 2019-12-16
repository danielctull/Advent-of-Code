
import Advent
import Foundation

public struct Day16 {

    public init() {}

    public func part1(input: Input, phases: Int = 100) -> String {

        let values = input
            .lines
            .first!
            .string
            .map { Int(String($0))! }

        let basePattern = [0, 1, 0, -1]
        let count = values.count

        let output = (1...phases)
            .reduce(values) { values, phase -> [Int] in

                Array(zip(values.repeating, 0..<count*count)) // Limit repeating length
                    .map { $0.0 } // Remove count value used to limit
                    .split(length: count) // Split into arrays
                    .enumerated()
                    .map { x -> Int in
                        let (iteration, values) = x

                        let base = basePattern
                            .repeatingElements(iteration + 1)
                            .repeating
                            .dropFirst()

                        let y = zip(values, base)
                            .map(*)
                            .reduce(0, +)

                        return abs(y)
                            .quotientAndRemainder(dividingBy: 10)
                            .remainder
                }
        }
        .map(String.init)
        .joined()
        
        return String(output.takeFirst(8))
    }

    public func part2(input: Input, phases: Int = 100) -> String {

        let string = input
            .lines
            .first!
            .string

        let dropAmount = Int(String(string.takeFirst(7))) ?? 0

        let values = Array(repeating: string, count: 10000)
            .joined()
            .map { Int(String($0))! }
            .dropFirst(dropAmount)
            .map { $0 }

        let output = (1...phases)
            .reduce(values) { values, phase -> [Int] in

                // Because we remove more than 50% of the values, the new value
                // will be the sum of all of the values furth than its index.
                //
                // For the list: a b c d e f g
                // We want to add from the end of the list, because:
                //
                // a b c d e f g
                // 1 1 1 1 1 1 1 => new a = a + b + c + d + e + f + g
                // 0 1 1 1 1 1 1 => new b = b + c + d + e + f + g
                // 0 0 1 1 1 1 1 => new c = c + d + e + f + g
                // 0 0 0 1 1 1 1 => new d = d + e + f + g
                // 0 0 0 0 1 1 1 => new e = e + f + g
                // 0 0 0 0 0 1 1 => new f = f + g
                // 0 0 0 0 0 0 1 => new g = g
                //
                // So lets accumulate from the end of values: reverse,
                // accumulate, dropFirst (fucking stupid, need scan), reverse
                // it back, then apply the remainder logic to each.

                values
                    .reversed()
                    .accumulating(0, +)
                    .dropFirst()
                    .reversed()
                    .map {
                        abs($0).quotientAndRemainder(dividingBy: 10).remainder
                    }
            }
            .map(String.init)
            .joined()

        return String(output.takeFirst(8))
    }
}
