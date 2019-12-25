
import Foundation
import Year2019

struct IntcodeTool {

    var computer: IntcodeComputer
    let mode: Mode

    init(arguments: [String]) throws {
        guard arguments.count == 3 else { throw Usage() }
        mode = try Mode(arguments[1])
        computer = try IntcodeComputer(path: arguments[2])
    }

    mutating func run() throws {

        while !computer.isHalted {

            try computer.run()
            print(computer.nextOutput(for: mode))

            guard computer.isWaiting, let input = readLine() else { continue }
            try computer.input(input, for: mode)
        }
    }
}

extension IntcodeComputer {

    fileprivate init(path: String) throws {

        let current = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
        let intcodeURL = URL(fileURLWithPath: path, relativeTo: current)
        let data = try Data(contentsOf: intcodeURL)
        guard let string = String(data: data, encoding: .utf8) else { throw NotString() }

        let code = try string
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: ",")
            .map(Int.init(code:))

        self.init(code: code)
    }

    fileprivate mutating func input(_ value: String, for mode: Mode) throws {
        switch mode {
        case .ascii: try ascii.input(value + "\n")
        case .int: try input(Int(code: value))
        }
    }

    fileprivate mutating func nextOutput(for mode: Mode) -> String {
        switch mode {
        case .ascii: return ascii.nextOutput()
        case .int: return nextOutput().map(String.init).joined(separator: ", ")
        }
    }
}

// MARK: - Errors

struct NotString: Error {}

struct Usage: LocalizedError {
    var errorDescription: String? { "intcode [int|ascii] [intcode filepath]" }
}

struct NotInteger: LocalizedError {
    let value: String
    var errorDescription: String? { "Expected integer but received \(value)." }
}

// MARK: - Int conversion

extension Int {

    init(code string: String) throws {
        guard let int = Int(string) else { throw NotInteger(value: string) }
        self = int
    }
}

// MARK: - Mode

enum Mode {
    case int
    case ascii
}

extension Mode {

    init(_ name: String) throws {
        struct NotMode: Error {}
        switch name {
        case "int": self = .int
        case "ascii": self = .ascii
        default: throw NotMode()
        }
    }
}
