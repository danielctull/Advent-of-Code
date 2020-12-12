
import Advent
import ArgumentParser
import Year2020

struct SolveCommand: ParsableCommand {

    @Argument(help: "The year.")
    var year: Int

    @Argument(help: "The day.")
    var day: Int

    @Argument(help: "The part.")
    var part: Int

    @Argument(help: "The part.")
    var input: Input

    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "solve")
    }

    func run() throws {
        try Year2020.Day11().part1(<#T##input: Input##Input#>)
    }
}

extension Input: ExpressibleByArgument {

    public init?(argument: String) {
        
    }
}
