
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

//   0:      1:      2:      3:      4:
//  aaaa    ....    aaaa    aaaa    ....
// b    c  .    c  .    c  .    c  b    c
// b    c  .    c  .    c  .    c  b    c
//  ....    ....    dddd    dddd    dddd
// e    f  .    f  e    .  .    f  .    f
// e    f  .    f  e    .  .    f  .    f
//  gggg    ....    gggg    gggg    ....
//
//   5:      6:      7:      8:      9:
//  aaaa    aaaa    aaaa    aaaa    aaaa
// b    .  b    .  .    c  b    c  b    c
// b    .  b    .  .    c  b    c  b    c
//  dddd    dddd    ....    dddd    dddd
// .    f  e    f  .    f  e    f  .    f
// .    f  e    f  .    f  e    f  .    f
//  gggg    gggg    ....    gggg    gggg

//  #1:          c        f       * 2 characters
//  #7:    a     c        f       * 3 characters
//  #4:       b  c  d     f       * 4 characters
//  #2:    a     c  d  e     g    * 5 characters not #5 or #3
//  #5:    a  b     d     f  g    * 5 characters superset of (#4 subtracting #7)
//  #3:    a     c  d     f  g    * 5 characters superset of #1
//  #9:    a  b  c  d     f  g    * 6 characters superset of #4
//  #0:    a  b  c     e  f  g    * 6 characters not #9 or #6
//  #6:    a  b     d  e  f  g    * 6 characters not superset of #1
//  #8:    a  b  c  d  e  f  g    * 7 characters

extension Day08.Mapping {

    init(patterns: String) throws {

        let patterns = patterns
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
            .map(Set.init)

        func pattern(
            count: Int,
            where predicate: (Set<Character>) -> Bool = { _ in true }
        ) throws -> Set<Character> {
            try patterns
                .first(where: { $0.count == count && predicate($0) })
                .unwrapped
        }

        let one   = try pattern(count: 2)
        let seven = try pattern(count: 3)
        let four  = try pattern(count: 4)
        let eight = try pattern(count: 7)
        let three = try pattern(count: 5) { $0.isSuperset(of: one) }
        let five  = try pattern(count: 5) { $0.isSuperset(of: four.subtracting(seven)) }
        let two   = try pattern(count: 5) { ![three, five].contains($0) }
        let nine  = try pattern(count: 6) { $0.isSuperset(of: four) }
        let six   = try pattern(count: 6) { !$0.isSuperset(of: one) }
        let zero  = try pattern(count: 6) { ![nine, six].contains($0) }

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
