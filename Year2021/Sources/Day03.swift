
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

        func iterate(using value: ([Character]) -> Character?) throws -> [Character] {
            try input.lines
                .map(Array.init)
                .single { values, iteration in
                    let character = value(values.transpose()[iteration])
                    values.filtered { $0[iteration] == character }
                }
                .unwrapped()
        }

        let oxygen = try BinaryNumber(iterate(using: \.most))
        let co2 = try BinaryNumber(iterate(using: \.least))
        return Int(oxygen) * Int(co2)
    }
}
