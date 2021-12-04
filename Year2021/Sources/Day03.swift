
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

        let most = try input.lines
            .map(Array.init)
            .single { values, iteration in

                let value = values
                    .transpose()[iteration]
                    .most

                values.filtered { $0[iteration] == value }
            }
            .unwrapped()

        let least = try input.lines
            .map(Array.init)
            .single { values, index in

                let value = values
                    .transpose()[index]
                    .least

                values.filtered { $0[index] == value }
            }
            .unwrapped()

        let oxygen = try BinaryNumber(most)
        let co2 = try BinaryNumber(least)
        return Int(oxygen) * Int(co2)
    }
}
