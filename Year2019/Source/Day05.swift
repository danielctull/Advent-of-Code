
import Advent
import Foundation

public struct Day05 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        return try IntcodeComputer(code: intcode)
            .run(1)
            .value
    }

    public func part2(input: Input) throws -> Int {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        return try IntcodeComputer(code: intcode)
            .run(5)
            .value
    }
}
