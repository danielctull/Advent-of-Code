
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

        let eightDays = (0...9)
            .map(Lanternfish.init)
            .map { lanternfish in
                (1...8).reduce([lanternfish]) { fish, _ in fish.flatMap(\.ticktock) }
            }

        let amount = amount/8

        let lanternfish = try input.lines
            .first.unwrapped
            .split(separator: ",")
            .map(Int.init)
            .map(Lanternfish.init)

        return (1...amount)
            .reduce(lanternfish) { fish, _ in
                fish.flatMap { eightDays[$0.timer] }
            }
            .count
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
