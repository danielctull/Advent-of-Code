
import Advent
import Algorithms
import Foundation

public enum Day06: Day {

    public static let title = "Lanternfish"

    public static func part1(_ input: Input) throws -> Int {

        let lanternfish = try input.lines
            .first.unwrapped
            .split(separator: ",")
            .map(Int.init)
            .map(Lanternfish.init)

        return (1...80)
            .reduce(lanternfish) { fish, _ in fish.flatMap(\.ticktock) }
            .count
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day06 {

    struct Lanternfish {
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
