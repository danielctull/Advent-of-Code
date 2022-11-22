
import Advent
import ArgumentParser
import Foundation
import Year2020

struct Solve: ParsableCommand {

    @Argument(help: "The year.")
    var year: Int

    @Argument(help: "The day.")
    var day: Int

    @Argument(help: "The input.")
    var input: Input

    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "solve")
    }

    func run() throws {
        let y = try getYear(at: year)
        let d = try y.day(at: day)

        let title = "Advent of Code \(year)"
        let subtitle = "Day \(day) \(d.title)"
        let part1 = "Part 1: \(try d.part1(input))"
        let part2 = "Part 2: \(try d.part2(input))"

        let output = [title, subtitle, "", part1, part2]
        let length = output.map(\.count).max()!
        let boundary = String(repeating: "~", count: length)

        print(boundary)
        print(output.joined(separator: "\n"))
        print(boundary)
    }
}

extension Input: ExpressibleByArgument {

    public init?(argument: String) {
        guard let directory = Process().currentDirectoryURL else { return nil }
        let url = directory.appendingPathComponent(argument)
        try? self.init(url: url)
    }
}
