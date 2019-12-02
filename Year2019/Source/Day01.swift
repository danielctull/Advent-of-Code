
import Advent
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        input
            .lines
            .compactMap { Double($0.string) }
            .map { Int(floor($0 / 3)) - 2 }
            .reduce(0, +)
    }

    public func part2(input: Input) -> Int {

        input
            .lines
            .compactMap { Int($0.string) }
            .map(fuel(for:))
            .reduce(0, +)
    }

    private func fuel(for mass: Int) -> Int {
        let fuel = Int(floor(Double(mass) / 3)) - 2

        guard fuel >= 0 else { return 0 }

        return fuel + self.fuel(for: fuel)
    }
}
