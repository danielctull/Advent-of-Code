
import ArgumentParser

struct AdventCommand: ParsableCommand {

    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "aoc",
            subcommands: [SolveCommand  .self])
    }
}
