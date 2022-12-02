
import Advent
import Algorithms
import Foundation

public enum Day02: Day {

    public static let title = "Rock Paper Scissors"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map { try (theirs: Shape($0.first), mine: Shape($0.last)) }
            .sum { $0.theirs.result(with: $0.mine).rawValue + $0.mine.rawValue }
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .map { try (theirs: Shape($0.first), result: Result($0.last)) }
            .sum { $0.theirs.mine(with: $0.result).rawValue + $0.result.rawValue }
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

    func mine(with result: Day02.Result) -> Self {
        switch (self, result) {
        case (.rock, .win), (.paper, .draw), (.scissors, .lose): return .paper
        case (.rock, .draw), (.paper, .lose), (.scissors, .win): return .rock
        case (.rock, .lose), (.paper, .win), (.scissors, .draw): return .scissors
        }
    }
}

extension Day02.Result {

    init(_ character: Character?) throws {
        switch character {
        case "X": self = .lose
        case "Y": self = .draw
        case "Z": self = .win
        default: throw UnexpectedRawValue(rawValue: character)
        }
    }
}
