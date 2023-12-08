
import Advent
import Algorithms
import RegexBuilder

public enum Day08: Day {

    public static let title = "Haunted Wasteland"

    public static func part1(_ input: Input) throws -> Int {

        let output = try regex.match(in: input.string).output

        var instructions = try Array<Instruction>(output.1)
            .cycled()
            .enumerated()
            .makeIterator()

        let network = try output.2
            .map { (String($0.1), String($0.2), String($0.3)) }
            .group(by: \.0)
            .mapValues { try ($0.first.unwrapped.1, $0.first.unwrapped.2) }

        var current = "AAA"

        while current != "ZZZ" {
            let instruction = try instructions.next().unwrapped.element
            let next = try network[current].unwrapped
            switch instruction {
            case .left: current = next.0
            case .right: current = next.1
            }
        }

        return try instructions.next().unwrapped.offset
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }

    fileprivate static let regex = Regex {
        Capture(OneOrMore(.word))
        One(.newlineSequence)
        Capture {
            List {
                One(.newlineSequence)
                Capture(OneOrMore(.word))
                " = ("
                Capture(OneOrMore(.word))
                ", "
                Capture(OneOrMore(.word))
                ")"
            }
        }
    }
}

private enum Instruction {
    case left, right
}

extension Instruction: CustomStringConvertible {
    var description: String {
        switch self {
        case .left: "left"
        case .right: "right"
        }
    }
}

extension Array<Instruction> {
    init(_ string: some StringProtocol) throws {
        self = try string.map {
            switch $0 {
            case "L": .left
            case "R": .right
            default: throw UnexpectedRawValue(rawValue: $0)
            }
        }
    }
}
