
import Advent
import Foundation

public struct Day05 {

    public init() {}

    public func part1(input: Input) throws -> Int? {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        var computer =  IntcodeComputer(code: intcode)
        computer.loadInput(1)
        try computer.run()
        return computer.output.last
    }

    public func part2(input: Input) throws -> Int? {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        var computer =  IntcodeComputer(code: intcode)
        computer.loadInput(5)
        try computer.run()
        return computer.output.last
    }
}
