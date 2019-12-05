
import Advent
import Foundation

public struct Day05 {

    public init() {}

    public func part1(input: Input) -> Int {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        return IntcodeComputer(code: intcode, input: 1)
            .run()
            .value
    }

    public func part2(input: Input) -> Int {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        return IntcodeComputer(code: intcode, input: 5)
            .run()
            .value
    }
}
