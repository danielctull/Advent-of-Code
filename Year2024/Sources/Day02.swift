
import Advent

public enum Day02: Day {

    public static let title = "Red-Nosed Reports"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines.count {
            let values = try $0
                .split(whereSeparator:(\.isWhitespace))
                .map(Int.init)

            return check(differences(values))
        }
    }

    public static func part2(_ input: Input) throws -> Int {
        try input.lines.count {
            let values = try $0
                .split(whereSeparator:(\.isWhitespace))
                .map(Int.init)

            if check(differences(values)) { return true }

            return (0..<values.count).contains { index in
                var new = values
                new.remove(at: index)
                return check(differences(new))
            }
        }
    }
}

fileprivate func differences(_ values: [Int]) -> [Int] {
    zip(values.dropFirst(), values).map(-)
}

fileprivate func check(_ differences: [Int]) -> Bool {
    differences.map(abs).allSatisfy { 0 < $0 && $0 < 4 }
        && differences.map(\.signum).allSame
}
