
import Advent
import Foundation

public struct Day01 {

    public init() {}

    public func part1(input: Input) -> Int {

        input
            .lines
            .compactMap(Double.init)
            .map { Int(floor($0 / 3)) - 2 }
            .sum()
    }

    public func part2(input: Input) -> Int {

        input
            .lines
            .compactMap(Int.init)
            .map(fuel(for:))
            .sum()
    }

    private func fuel(for mass: Int) -> Int {
        let fuel = Int(floor(Double(mass) / 3)) - 2

        guard fuel >= 0 else { return 0 }

        return fuel + self.fuel(for: fuel)
    }
}
