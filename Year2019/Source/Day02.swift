
import Advent
import Foundation

public struct Day02 {

    public init() {}

    public func part1(input: Input) -> [Int] {

        var intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        if !input.testing {
            intcode[1] = 12
            intcode[2] = 2
        }

        return IntcodeComputer(code: intcode)
            .run()
            .code
    }

    public func part2(input: Input) -> Int {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        for (noun, verb) in zip((0...99).repeatingElements(100), (0...99).repeating) {
            var code = intcode
            code[1] = noun
            code[2] = verb

            let output = IntcodeComputer(code: code)
                .run()
                .code

            if output[0] == 19690720 {
                return 100 * noun + verb
            }
        }

        return 0
    }
}
