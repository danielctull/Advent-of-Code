
import ArgumentParser

@main
struct Advent: ParsableCommand {

    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "aoc",
            subcommands: [
                Create.self,
                Solve.self
            ])
    }
}
