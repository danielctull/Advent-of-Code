
import Advent
import Algorithms
import Foundation

public enum Day02: Day {

    public static let title = "Rock Paper Scissors"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map(Round.init)
            .map(\.score)
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day02 {

    fileprivate struct Round {
        let theirs: Shape
        let mine: Shape
    }

    fileprivate enum Shape {
        case rock
        case paper
        case scissors
    }
}

extension Day02.Round: RawRepresentable {

    init?(rawValue: String) {
        guard let first = rawValue.first, let last = rawValue.last else { return nil }
        switch first {
        case "A": theirs = .rock
        case "B": theirs = .paper
        case "C": theirs = .scissors
        default: return nil
        }
        switch last {
        case "X": mine = .rock
        case "Y": mine = .paper
        case "Z": mine = .scissors
        default: return nil
        }
    }

    var rawValue: String {
        let first: Character
        switch theirs {
        case .rock: first = "A"
        case .paper: first = "B"
        case .scissors: first = "C"
        }
        let last: Character
        switch mine {
        case .rock: last = "X"
        case .paper: last = "Y"
        case .scissors: last = "Z"
        }
        return String([first, " ", last])
    }
}

extension Day02.Round {

    var result: Int {
        switch (theirs, mine) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): return 6
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors): return 3
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper): return 0
        }
    }

    var score: Int {
        result + mine.score
    }
}

extension Day02.Shape {

    var score: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }
}
