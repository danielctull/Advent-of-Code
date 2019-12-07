
import Advent
import Foundation

public struct Day07 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let code = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        func calculate(phases: [Int]) throws -> Int {
            try phases.reduce(0) { result, phase in
                var computer = IntcodeComputer(code: code)
                try computer.run(phase, result)
                return computer.state.value
            }
        }

        return try [0,1,2,3,4]
            .permutations
            .map(calculate(phases:))
            .reduce(0, max)
    }

    public func part2(input: Input) throws -> Int {
        0
    }
}
