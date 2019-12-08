
import Advent
import Foundation

public struct Day08 {

    public init() {}

    public func part1(width: Int, height: Int, input: Input) -> Int {

        input
            .lines
            .first!
            .string
            .split(length: width * height)
            .map { string -> (Int, Int) in
                let characters = string.group(by: { $0 })
                let zeros = characters["0"]?.count ?? 0
                let ones = characters["1"]?.count ?? 0
                let twos = characters["2"]?.count ?? 0
                return (zeros, ones * twos)
            }
            .min { $0.0 < $1.0 }?
            .1 ?? 0
    }
}
