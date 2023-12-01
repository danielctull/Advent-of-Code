
import Advent
import Algorithms
import Foundation

public enum Day01: Day {

    public static let title = "Trebuchet?!"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map {
                let first = try $0.first(where: \.isNumber).unwrapped
                let last = try $0.last(where: \.isNumber).unwrapped
                return try Int("\(first)\(last)")
            }
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .map { try Int("\($0.firstNumber)\($0.lastNumber)") }
            .sum
    }
}

private struct Number {
    let name: String
    let value: Int
}

extension BidirectionalCollection<Character> {

    fileprivate var firstNumber: Int {
        get throws {

            let values: [(index: Index, element: Int)] = Number.allCases.compactMap {
                guard let index = firstIndex(of: $0) else { return nil }
                return (index, $0.value)
            }

            let integers: [(index: Index, element: Int)] = Number.allCases.compactMap {
                guard let index = firstIndex(of: $0.value) else { return nil }
                return (index, $0.value)
            }

            return try (values + integers)
                .sorted(by: \.index)
                .first.unwrapped
                .element
        }
    }

    fileprivate var lastNumber: Int {
        get throws {

            let values: [(index: Index, element: Int)] = Number.allCases.compactMap {
                guard let index = lastIndex(of: $0) else { return nil }
                return (index, $0.value)
            }

            let integers: [(index: Index, element: Int)] = Number.allCases.compactMap {
                guard let index = lastIndex(of: $0.value) else { return nil }
                return (index, $0.value)
            }

            return try (values + integers)
                .sorted(by: \.index)
                .last.unwrapped
                .element
        }
    }

    fileprivate func firstIndex(of integer: Int) -> Index? {
        firstIndex(where: { (try? Int($0)) == integer })
    }

    fileprivate func lastIndex(of integer: Int) -> Index? {
        lastIndex(where: { (try? Int($0)) == integer })
    }

    fileprivate func firstIndex(of number: Number) -> Index? {
        windows(ofCount: number.name.count)
            .first { String($0) == number.name }?
            .startIndex
    }

    fileprivate func lastIndex(of number: Number) -> Index? {
        windows(ofCount: number.name.count)
            .last { String($0) == number.name }?
            .endIndex
    }
}

extension Number {
    static let one = Self(name: "one", value: 1)
    static let two = Self(name: "two", value: 2)
    static let three = Self(name: "three", value: 3)
    static let four = Self(name: "four", value: 4)
    static let five = Self(name: "five", value: 5)
    static let six = Self(name: "six", value: 6)
    static let seven = Self(name: "seven", value: 7)
    static let eight = Self(name: "eight", value: 8)
    static let nine = Self(name: "nine", value: 9)
}

extension Number: CaseIterable {
    static var allCases: [Self] {
        [
            .one,
            .two,
            .three,
            .four,
            .five,
            .six,
            .seven,
            .eight,
            .nine,
        ]
    }
}
