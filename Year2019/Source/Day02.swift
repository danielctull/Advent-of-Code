
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

        return calculate(intcode, operation: 0)
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
            let output = calculate(code, operation: 0)
            if output[0] == 19690720 {
                return 100 * noun + verb
            }
        }

        return 0
    }

    private func calculate(_ intcode: [Int], operation: Int) -> [Int] {

        var code = intcode

        func perform(_ closure: (Int, Int) -> Int) {
            let position1 = code[operation + 1]
            let position2 = code[operation + 2]
            let position3 = code[operation + 3]
            code[position3] = closure(code[position1], code[position2])
        }

        switch code[operation] {
        case 1: perform(+)
        case 2: perform(*)
        case 99: return code
        default: fatalError()
        }

        return calculate(code, operation: operation + 4)
    }
}
