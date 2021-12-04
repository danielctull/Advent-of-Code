
import Advent
import Algorithms
import Foundation

public enum Day03: Day {

    public static let title = "Binary Diagnostic"

    public static func part1(_ input: Input) throws -> Int {

        let most = try input.lines
            .transpose()
            .map { try $0.most.unwrapped() }

        let gamma = try BinaryNumber(most)
        let epsilon = !gamma
        return Int(gamma) * Int(epsilon)
    }

    public static func part2(_ input: Input) throws -> Int {

        var most = input.lines.map { Array($0) }
        do {
            var index = 0
            while most.count > 1 {

                let value = most
                    .transpose()[index]
                    .most

                most = most.filter { $0[index] == value }
                index += 1
            }
        }


        var least = input.lines.map { Array($0) }
        do {
            var index = 0
            while least.count > 1 {

                let value = least
                    .transpose()[index]
                    .least

                least = least.filter { $0[index] == value }
                index += 1
            }
        }

        let oxygen = try BinaryNumber(most.first.unwrapped())
        let co2 = try BinaryNumber(least.first.unwrapped())
        return Int(oxygen) * Int(co2)
    }
}
