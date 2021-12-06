
import Advent
import Algorithms
import Foundation

public enum Day06: Day {

    public static let title = "Lanternfish"

    public static func part1(_ input: Input) throws -> Int {
        try run(input, amount: 80)
    }

    public static func part2(_ input: Input) throws -> Int {
        try run(input, amount: 256)
    }

    private static func run(_ input: Input, amount: Int) throws -> Int {

        let school = try input.lines
            .first.unwrapped
            .split(separator: ",")
            .map(Int.init)
            .map(Lanternfish.init)
            .countByElement

        return (1...amount)
            .reduce(school) { school, _ in
                var out: [Lanternfish: Int] = [:]
                school.forEach { fish, count in
                    for fish in fish.ticktock {
                        out[fish, default: 0] += count
                    }
                }
                return out
            }
            .values
            .sum
    }
}

extension Day06 {

    struct Lanternfish: Hashable {
        let timer: Int
    }
}

extension Day06.Lanternfish {

    static let spawn = Self(timer: 8)
    static let reset = Self(timer: 6)

    var ticktock: [Self] {
        timer == 0
            ? [.reset, .spawn]
            : [Self(timer: timer - 1)]
    }
}

extension Day06.Lanternfish: CustomStringConvertible {
    var description: String { String(timer) }
}
