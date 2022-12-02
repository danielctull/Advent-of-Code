
import Advent

public enum Day02: Day {

    public static let title = "Rock Paper Scissors"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map { try (theirs: Shape($0.first), mine: Shape($0.last)) }
            .sum { Result($0).rawValue + $0.mine.rawValue }
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines
            .map { try (theirs: Shape($0.first), result: Result($0.last)) }
            .sum { Shape($0).rawValue + $0.result.rawValue }
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

    init(_ values: (theirs: Self, result: Day02.Result)) {
        switch (values.theirs, values.result) {
        case (.rock, .win), (.paper, .draw), (.scissors, .lose): self = .paper
        case (.rock, .draw), (.paper, .lose), (.scissors, .win): self = .rock
        case (.rock, .lose), (.paper, .win), (.scissors, .draw): self = .scissors
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

    init(_ values: (theirs: Day02.Shape, mine: Day02.Shape)) {
        switch (values.mine, values.theirs) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper): self = .win
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors): self = .draw
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock): self = .lose
        }
    }
}
