
import Advent
import Foundation

public struct Day02 {

    public init() {}

    public func part1(input: Input) throws -> [Int] {

        var intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        if !input.testing {
            intcode[1] = 12
            intcode[2] = 2
        }

        let computer =  IntcodeComputer(code: intcode)
        try computer.run()
        return computer.state.code
    }

    public func part2(input: Input) throws -> Int {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        for (noun, verb) in zip((0...99).repeatingElements(100), (0...99).repeating) {
            var code = intcode
            code[1] = noun
            code[2] = verb

            let computer =  IntcodeComputer(code: code)
            try computer.run()
            let output = computer.state.code

            if output[0] == 19690720 {
                return 100 * noun + verb
            }
        }

        return 0
    }
}
