
import Advent
import Algorithms
import Foundation

public struct Day02 {

    public init() {}

    public func part1(input: Input) throws -> [Int] {

        var computer =  IntcodeComputer(input: input)
        if !input.testing {
            computer.code[1] = 12
            computer.code[2] = 2
        }
        try computer.run()
        return computer.code
    }

    public func part2(input: Input) throws -> Int {

        for (noun, verb) in zip((0...99).repeatingElements(100), (0...99).cycled()) {

            var computer =  IntcodeComputer(input: input)
            computer.code[1] = noun
            computer.code[2] = verb
            try computer.run()

            if computer.code[0] == 19690720 {
                return 100 * noun + verb
            }
        }

        return 0
    }
}
