
import Advent
import Algorithms
import Foundation

public enum Day02: Day {

    public static let title = "Rock Paper Scissors"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map { try (theirs: Shape($0.first), mine: Shape($0.last)) }
            .map { $0.theirs.result(with: $0.mine).rawValue + $0.mine.rawValue }
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day02 {

    fileprivate enum Shape: Int {
        case rock = 1
        case paper = 2
        case scissors = 3
    }

    fileprivate enum Result: Int {
        case win = 6
        case draw = 3
        case lose = 0
    }
}

extension Day02.Shape {

    init(_ character: Character?) throws {
        switch character {
        case "A", "X": self = .rock
        case "B", "Y": self = .paper
        case "C", "Z": self = .scissors
        default: throw UnexpectedRawValue(rawValue: character)
        }
    }

    func result(with mine: Self) -> Day02.Result {
        switch (self, mine) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): return .win
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors): return .draw
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper): return .lose
        }
    }
}
