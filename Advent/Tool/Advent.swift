
import ArgumentParser

@main
struct Advent: AsyncParsableCommand {

    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "aoc",
            subcommands: [
                Cookie.self,
                Create.self,
                Solve.self,
            ])
    }
}
