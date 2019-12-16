
import Advent
import Foundation

public struct Day16 {

    public init() {}

    public func part1(input: Input, phases: Int = 100) -> String {
        calculate(input: input, phases: phases)
    }

    public func part2(input: Input, phases: Int = 100) -> String {
        calculate(input: input,
                  phases: phases,
                  repeatAmount: 10000,
                  dropValue: 7)
    }

    private func calculate(
        input: Input,
        phases: Int,
        repeatAmount: Int = 1,
        dropValue: Int = 0
    ) -> String {

        let string = input.lines.first!.string
        let dropAmount = Int(String(string.takeFirst(dropValue))) ?? 0

        let values = Array(repeating: string, count: repeatAmount)
            .joined()
            .map { Int(String($0))! }
            .dropFirst(dropAmount)
            .map { $0 }

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
                            .dropFirst(dropAmount + 1)

                        let value = zip(values, base)
                            .map(*)
                            .reduce(0, +)

                        return abs(value)
                            .quotientAndRemainder(dividingBy: 10)
                            .remainder
                    }
            }
            .map(String.init)
            .joined()

        return String(output.takeFirst(8))
    }
}
