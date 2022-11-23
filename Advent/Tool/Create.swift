
import ArgumentParser
import FileBuilder
import Foundation
import KeychainItem

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct Create: AsyncParsableCommand {

    @Argument(help: "The year of the puzzle.")
    var year: Year = .current

    @Argument(help: "The day of the puzzle.")
    var day: Day = .current

    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "create",
            abstract: "Create empty source, test and input files for an Advent of Code puzzle.")
    }

    func run() async throws {

#if canImport(Security)
        let cookie = await Keychain(.sessionCookie).wrappedValue

        let inputData = try await URLSession
            .configured(with: cookie)
            .data(from: .input(day: day, year: year))
            .0
#else
        let inputData = Data()
#endif

        try Directory("\(year)") {
            Directory("Sources") {
                SourceFile(day: day)
            }
            Directory("Tests") {
                TestFile(day: day, year: year)
                Directory("Inputs") {
                    InputFile(day: day, data: inputData)
                }
            }
        }
        .write(in: FileManager().currentDirectory)
    }
}

// MARK: - Files

private struct SourceFile: File {

    let day: Create.Day

    var body: some File {
        TextFile("\(day).swift") {
            """

            import Advent
            import Algorithms
            import Foundation

            public enum \(day): Day {

                public static let title = ""

                public static func part1(_ input: Input) throws -> Int {
                    0
                }

                public static func part2(_ input: Input) throws -> Int {
                    0
                }
            }
            """
        }
    }
}

private struct TestFile: File {

    let day: Create.Day
    let year: Create.Year

    var body: some File {
        TextFile("\(day)Tests.swift") {
            """

            import Advent
            import \(year)
            import XCTest

            final class \(day)Tests: XCTestCase {

                func testPart1Examples() throws {
                    XCTAssertEqual(try \(day).part1([]), 0)
                }

                func testPart1Puzzle() throws {
                    let input = try Bundle.module.input(named: "\(day)")
                    XCTAssertEqual(try \(day).part1(input), 0)
                }

                func testPart2Examples() throws {
                    XCTAssertEqual(try \(day).part2([]), 0)
                }

                func testPart2Puzzle() throws {
                    let input = try Bundle.module.input(named: "\(day)")
                    XCTAssertEqual(try \(day).part2(input), 0)
                }
            }
            """
        }
    }
}

private struct InputFile: File {

    let day: Create.Day
    let data: Data

    var body: some File {
        DataFile("\(day).txt", data: data)
    }
}

// MARK: - Day

extension Create {

    struct Day {
        fileprivate let value: Int
    }
}

extension Create.Day {

    static var current: Self {
        Self(value: Calendar.gregorian.value(for: .day, from: Date()))
    }
}

extension Create.Day: ExpressibleByArgument {

    init?(argument: String) {
        guard let value = Int(argument: argument) else { return nil }
        self.value = value
    }
}

extension Create.Day: CustomStringConvertible {

    var description: String { value.description }
}

extension String.StringInterpolation {

    mutating func appendInterpolation(_ day: Create.Day) {
        appendInterpolation("Day" + String(format: "%02d", day.value))
    }
}

// MARK: - Year

extension Create {

    struct Year {
        fileprivate let value: Int
    }
}

extension Create.Year {

    static var current: Self {
        Self(value: Calendar.gregorian.value(for: .year, from: Date()))
    }
}

extension Create.Year: ExpressibleByArgument {

    init?(argument: String) {
        guard let value = Int(argument: argument) else { return nil }
        self.value = value
    }
}

extension Create.Year: CustomStringConvertible {

    var description: String { value.description }
}

extension String.StringInterpolation {

    mutating func appendInterpolation(_ year: Create.Year) {
        appendInterpolation("Year\(year.value)")
    }
}

// MARK: - Input Data

extension URL {

    static func input(day: Create.Day, year: Create.Year) -> Self {
        self.init(string: "https://adventofcode.com/\(year.value)/day/\(day.value)/input")!
    }
}

extension URLSession {

    static func configured(with cookie: SessionCookie?) -> URLSession {

        guard let cookie else { return URLSession.shared }

        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .always
        config.httpCookieStorage?.setCookie(HTTPCookie(properties: [
            .domain: ".adventofcode.com",
            .path: "",
            .secure: true,
            .name: "session",
            .value: cookie.value,
        ])!)

        return URLSession(configuration: config)
    }
}

// MARK: - Calendar

extension Calendar {

    static let gregorian = Self(identifier: .gregorian)

    func value(for component: Calendar.Component, from date: Date) -> Int {
        dateComponents([component], from: date).value(for: component)!
    }
}

// MARK: - FileManager

extension FileManager {

    fileprivate var currentDirectory: URL {
        URL(fileURLWithPath: currentDirectoryPath)
    }
}
