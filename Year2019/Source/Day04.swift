
import Advent
import Foundation

public struct Day04 {

    public init() {}

    public func part1(input: Input) -> Int {

        input
            .lines
            .map { ClosedRange($0.string) }
            .first!
            .filter(twoAdjacentDigits)
            .filter(digitsDontDecrease)
            .count
    }
}

fileprivate func twoAdjacentDigits(_ input: Int) -> Bool {
    let string = String(input)
    return zip(string, string.dropFirst())
        .map(==)
        .contains(true)
}

fileprivate func digitsDontDecrease(_ input: Int) -> Bool {
    let string = String(input)
    return !zip(string, string.dropFirst())
        .map(>=)
        .contains(false)
}

extension ClosedRange where Bound == Int {

    fileprivate init(_ string: String) {
        let parts = string.split(separator: "-")
        let lower = Int(String(parts[0]))!
        let upper = Int(String(parts[1]))!
        self = lower...upper
    }
}
