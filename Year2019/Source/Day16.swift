
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

        return (1...phases)
            .reduce(values) { values, _ -> [Int] in

                (1...values.count).map { iteration -> Int in

                    let base = basePattern
                        .repeatingElements(iteration)
                        .repeating
                        .dropFirst()

                    let value = zip(values, base).map(*).reduce(0, +)
                    return abs(value) % 10
                }
            }
            .prefix(8)
            .map(String.init)
            .joined()
    }

    // Because we remove more than 50% of the values, the new value
    // will be the sum of all of the values further than its index.
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
    public func part2(input: Input, phases: Int = 100) -> String {

        let string = input
            .lines
            .first!
            .string

        let dropAmount = Int(String(string.prefix(7)))!
        let values = string
            .map { Int(String($0))! }
            .repeating(10_000)
            .flatMap { $0 }
            .dropFirst(dropAmount)
            .map { $0 }

        return (1...phases)
            .reduce(values) { values, phase -> [Int] in

                var total = values.reduce(0, +)
                return values.map { value in
                    defer { total -= value }
                    return total % 10
                }
            }
            .prefix(8)
            .map(String.init)
            .joined()
    }
}
