
import Advent
import Foundation

public struct Day09 {
    
    public init() {}
    
    public func part1(input: Input) throws -> Int? {
        var computer = IntcodeComputer(input: input)
        computer.input(1)
        try computer.run()
        return computer.output.last
    }
    
    public func part2(input: Input) throws -> Int? {
        var computer = IntcodeComputer(input: input)
        computer.input(2)
        try computer.run()
        return computer.output.last
    }
}
