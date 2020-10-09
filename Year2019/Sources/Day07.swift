
import Advent
import Algorithms
import Foundation

public struct Day07 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        try [0,1,2,3,4]
            .permutations
            .map { try calculatePart1(input: input, phases: $0) }
            .reduce(0, max)
    }

    public func calculatePart1(input: Input, phases: [Int]) throws -> Int {

        try phases.reduce(0) { result, phase in
            var computer = IntcodeComputer(input: input)
            computer.input(phase)
            computer.input(result)
            try computer.run()
            return computer.output.last ?? .min
        }
    }

    public func part2(input: Input) throws -> Int {

        try [5,6,7,8,9]
            .permutations
            .map { try calculatePart2(input: input, phases: $0) }
            .reduce(0, max)
    }

    public func calculatePart2(input: Input, phases: [Int]) throws -> Int {

        // Set up computers with phases.
        var computers = try phases.map { phase -> IntcodeComputer in
            var computer = IntcodeComputer(input: input)
            computer.input(phase)
            try computer.run()
            return computer
        }

        var iterator = (0..<phases.count).cycled().makeIterator()
        var value = 0

        while !computers.last!.isHalted, let index = iterator.next() {
            var computer = computers[index]
            computer.input(value)
            try computer.run()
            value = computer.output.last ?? .min
            computers[index] = computer
        }

        return value
    }
}
