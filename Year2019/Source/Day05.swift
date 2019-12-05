
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

        var computer = IntcodeComputer(memory: intcode, input: 1)
        computer.run()
        return computer.value
    }

    public func part2(input: Input) -> Int {

        let intcode = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }

        var computer = IntcodeComputer(memory: intcode, input: 5)
        computer.run()
        return computer.value
    }
}
