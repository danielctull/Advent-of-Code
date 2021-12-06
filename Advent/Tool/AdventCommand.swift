
import ArgumentParser

struct AdventCommand: ParsableCommand {

    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "aoc",
            subcommands: [
                CreateCommand.self,
                SolveCommand.self
            ])
    }
}
