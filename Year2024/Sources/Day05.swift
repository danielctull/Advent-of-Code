
import Advent

public enum Day05: Day {

    public static let title = "Print Queue"

    public static func part1(_ input: Input) throws -> Int {
        let sections = input.lines
            .split(separator: "")

        let rules = try sections
            .first.unwrapped
            .map { try $0.split(separator: "|").map(Int.init) }
            .map { try ($0.first.unwrapped, $0.last.unwrapped) }
            .group(by: \.0)
            .mapValues { Set($0.map(\.1)) }

        return try sections
            .last.unwrapped
            .map { try $0.split(separator: ",").map(Int.init) }
            .filter {
                var seen: Set<Int> = []
                return $0.allSatisfy { value in
                    defer { seen.insert(value) }
                    let disallowed = rules[value] ?? []
                    return seen.intersection(disallowed).count == 0
                }
            }
            .sum(of: \.middle)
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
