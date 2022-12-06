
import Advent
import Algorithms

public enum Day06: Day {

    public static let title = "Tuning Trouble"

    public static func part1(_ input: Input) throws -> Int {
        let line = try input.lines.first.unwrapped
        let windows = line.windows(ofCount: 4)
        let index = try windows.firstIndex { Set($0).count == 4 }.unwrapped
        return windows.distance(from: windows.startIndex, to: index) + 4
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
