
import Advent
import Foundation

public enum Day23: Day {

    public static let title = "Crab Cups"

    public static func part1(_ input: Input) throws -> Int {
        let moves = input.testing ? 10 : 100
        var cups = try Cups(input)
        for _ in 0..<moves { try cups.move() }
        return try cups.sequence
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day23 {

    fileprivate struct Cups {
        private var values: [Int]
        private let sorted: [Int]
        init(_ input: Input) throws {
            values = try input.lines.first.unwrapped.map(Int.init)
            sorted = values.sorted()
        }

        mutating func move() throws {
            let current = values.removeFirst()
            let three = [values.removeFirst(), values.removeFirst(), values.removeFirst()]
            let destination = try nextCup(current)
            let index = try values.firstIndex(of: destination).unwrapped
            values.insert(contentsOf: three, at: values.index(after: index))
            values.append(current)
        }

        private func nextCup(_ current: Int) throws -> Int {
            var index = try sorted.firstIndex(of: current).unwrapped
            var destination = current
            repeat {
                index = sorted.startIndex < index
                    ? sorted.index(before: index)
                    : sorted.index(before: sorted.endIndex)
                destination = sorted[index]
            } while !values.contains(destination)
            return destination
        }

        var sequence: Int {
            get throws {
                let split = values.split(separator: 1)
                let first = try Array(split.first.unwrapped)
                let last = try Array(split.last.unwrapped)
                let numbers = (first == last)
                    ? Array(first)
                    : Array(last) + Array(first)
                let string = numbers.map(String.init).joined()
                return try Int(string).unwrapped
            }
        }
    }
}
