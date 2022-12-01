
import Advent
import ArgumentParser
import Foundation
import Year2019

@main
struct Intcode: ParsableCommand {

    static let configuration = CommandConfiguration(commandName: "intcode")

    @Argument(help: "The mode to use. [\(Mode.allValueStrings.joined(separator: "|"))]", completion: .list(Mode.allValueStrings))
    var mode: Mode

    @Argument(help: "The input.")
    var input: Input

    func run() throws {

        var computer = IntcodeComputer(input: input)

        while !computer.isHalted {

            try computer.run()
            print(computer.nextOutput(for: mode))

            guard computer.isWaiting, let input = readLine() else { continue }
            try computer.input(input, for: mode)
        }
    }
}

// MARK: - Intcode Computer

extension IntcodeComputer {

    fileprivate mutating func input(_ value: String, for mode: Mode) throws {
        switch mode {
        case .ascii: try ascii.input(value + "\n")
        case .int: try input(Int(value))
        }
    }

    fileprivate mutating func nextOutput(for mode: Mode) -> String {
        switch mode {
        case .ascii: return ascii.nextOutput()
        case .int: return nextOutput().map(String.init).joined(separator: ", ")
        }
    }
}

// MARK: - Input

extension Input: ExpressibleByArgument {

    public init?(argument: String) {
        guard let directory = Process().currentDirectoryURL else { return nil }
        let url = directory.appendingPathComponent(argument)
        try? self.init(url: url)
    }
}

// MARK: - Mode

enum Mode: String, ExpressibleByArgument {
    case int
    case ascii

    static var allValueStrings: [String] { ["int", "ascii"] }
}
