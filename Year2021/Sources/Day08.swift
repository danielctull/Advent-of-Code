
import Advent
import Algorithms
import Foundation

public enum Day08: Day {

    public static let title = "Seven Segment Search"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .flatMap {
                try $0.split(separator: "|")
                    .last.unwrapped
                    .components(separatedBy: .whitespaces)
                    .map(\.count)
            }
            .count(where: [2,4,3,7].contains)
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .map { line in
                let segments = line.components(separatedBy: "|")
                let mapping = try Mapping(patterns: segments.first.unwrapped)
                return try mapping.value(for: segments.last.unwrapped)
            }
            .sum
    }
}

extension Day08 {

    struct Mapping {
        let dictionary: [Set<Character>: Int]
    }
}

//  #1:          c        f       * Initial
//  #7:    a     c        f       * Initial
//  #4:       b  c  d     f       * Initial
//  #2:    a     c  d  e     g    * 5 characters not #5 or #3
//  #5:    a  b     d     f  g    * 5 characters superset of (#4 subtracting #7)
//  #3:    a     c  d     f  g    * 5 characters superset of #1
//  #9:    a  b  c  d     f  g    * 6 characters superset of #4
//  #0:    a  b  c     e  f  g    * 6 characters not #9 or #6
//  #6:    a  b     d  e  f  g    * 6 characters not superset of #1
//  #8:    a  b  c  d  e  f  g    * Initial

extension Day08.Mapping {

    init(patterns: String) throws {

        let patterns = patterns
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .map(Set.init)

        let one   = try patterns.first(where: { $0.count == 2 }).unwrapped
        let seven = try patterns.first(where: { $0.count == 3 }).unwrapped
        let four  = try patterns.first(where: { $0.count == 4 }).unwrapped
        let eight = try patterns.first(where: { $0.count == 7 }).unwrapped
        let three = try patterns.first(where: { $0.count == 5 && $0.isSuperset(of: one) }).unwrapped
        let five  = try patterns.first(where: { $0.count == 5 && $0.isSuperset(of: four.subtracting(seven)) }).unwrapped
        let two   = try patterns.first(where: { $0.count == 5 && ![three, five].contains($0) }).unwrapped
        let nine  = try patterns.first(where: { $0.count == 6 && $0.isSuperset(of: four) }).unwrapped
        let six   = try patterns.first(where: { $0.count == 6 && !$0.isSuperset(of: one) }).unwrapped
        let zero  = try patterns.first(where: { $0.count == 6 && ![nine, six].contains($0) }).unwrapped

        self.dictionary = [zero: 0, one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9]
    }

    func value(for output: String) throws -> Int {
        try output
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .map(Set.init)
            .map { try dictionary[$0].unwrapped }
            .reversed()
            .enumerated()
            .map { index, value in value * 10.power(index) }
            .sum
    }
}
