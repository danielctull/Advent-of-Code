
import Advent
import RegexBuilder

public enum Day21: Day {

    public static let title = "Monkey Math"

    private static let number = Regex {
        Capture.alpha
        ": "
        TryCapture.integer
    }

    private static let operation = Regex {
        Capture.alpha
        ": "
        Capture.alpha
        " "
        TryCapture(Job.Operation.self)
        " "
        Capture.alpha
    }

    public static func part1(_ input: Input) throws -> Int {

        try input.lines.map { line -> (String, Job) in

            if let output = try? number.match(in: line).output {
                return (output.1, .number(output.2))
            }

            let output = try operation.match(in: line).output
            return (output.1, .operation(output.2, output.3, output.4))
        }
        .reduce(into: [:]) { $0[$1.0] = $1.1 }
        .value(for: "root")
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Dictionary<String, Day21.Job> {

    fileprivate func value(for monkey: String) throws -> Int {
        let job = try self[monkey].unwrapped
        switch job {
        case let .number(value):
            return value
        case let .operation(m1, operation, m2):
            let v1 = try value(for: m1)
            let v2 = try value(for: m2)
            switch operation {
            case .plus: return v1 + v2
            case .minus: return v1 - v2
            case .divide: return v1 / v2
            case .multiply: return v1 * v2
            }
        }
    }
}

extension Day21 {

    fileprivate enum Job {
        case number(Int)
        case operation(String, Operation, String)

        enum Operation: Character {
            case plus = "+"
            case minus = "-"
            case divide = "/"
            case multiply = "*"
        }
    }
}
