
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


        return String(output.dropLast(output.count - 8))
    }
}
