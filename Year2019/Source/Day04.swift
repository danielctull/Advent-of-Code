
import Advent
import Foundation

public struct Day04 {

    public init() {}

    public func part1(input: Input) -> Int {

        input
            .lines
            .map { ClosedRange($0.string) }
            .first!
            .filter(digitsDontDecrease)
            .filter(twoAdjacentDigits)
            .count
    }

    public func part2(input: Input) -> Int {

        input
            .lines
            .map { ClosedRange($0.string) }
            .first!
            .filter(digitsDontDecrease)
            .filter(exactlyTwoAdjacentDigits)
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

fileprivate func exactlyTwoAdjacentDigits(_ input: Int) -> Bool {

    var value = Character("-")
    var count = 1

    for character in String(input) {

        if character == value {
            count += 1
            continue
        }

        if count == 2 { return true }

        value = character
        count = 1
    }

    return count == 2
}

extension ClosedRange where Bound == Int {

    fileprivate init(_ string: String) {
        let parts = string.split(separator: "-")
        let lower = Int(String(parts[0]))!
        let upper = Int(String(parts[1]))!
        self = lower...upper
    }
}
