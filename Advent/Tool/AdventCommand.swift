
import ArgumentParser

@main
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
