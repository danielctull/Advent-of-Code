
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

        return try [0,1,2,3,4]
            .permutations
            .map { try calculatePart1(code: code, phases: $0) }
            .reduce(0, max)
    }

    public func calculatePart1(code: [Int], phases: [Int]) throws -> Int {
        try phases.reduce(0) { result, phase in
            var computer = IntcodeComputer(code: code)
            try computer.run(phase, result)
            return computer.state.value
        }
    }

    public func part2(input: Input) throws -> Int {

        let code = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        return try [5,6,7,8,9]
            .permutations
            .map { try calculatePart2(code: code, phases: $0) }
            .reduce(0, max)
    }

    public func calculatePart2(code: [Int], phases: [Int]) throws -> Int {

        // Set up computers with phases.
        var computers = try phases.map { phase -> IntcodeComputer in
            var computer = IntcodeComputer(code: code)
            try computer.run(phase)
            return computer
        }

        var iterator = (0..<phases.count).repeating.makeIterator()
        var value = 0

        while !computers.last!.state.halted, let index = iterator.next() {
            var computer = computers[index]
            try computer.run(value)
            value = computer.state.value
            computers[index] = computer
        }

        return value
    }
}
