
import Advent
import Foundation

public struct Day09 {
    
    public init() {}
    
    public func part1(input: Input) throws -> Int? {
        
        let code = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }
        
        var computer =  IntcodeComputer(code: code)
        computer.input(1)
        try computer.run()
        return computer.output.last
    }
    
    public func part2(input: Input) throws -> Int? {
        
        let code = input
            .lines
            .map { $0.string }
            .flatMap { $0.components(separatedBy: ",") }
            .compactMap { Int($0) }
        
        var computer =  IntcodeComputer(code: code)
        computer.input(2)
        try computer.run()
        
        return computer.output.last
    }
}
