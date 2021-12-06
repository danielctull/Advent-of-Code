
import ArgumentParser
import Foundation

struct CreateCommand: ParsableCommand {

    @Argument(help: "The year.")
    var year: Int = { Calendar.gregorian.value(for: .year, from: Date()) }()

    @Argument(help: "The day.")
    var day: Int = { Calendar.gregorian.value(for: .day, from: Date()) }()

    private var dayString: String { String(format: "%02d", day) }

    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "create")
    }

    func run() throws {
        let fileManager = FileManager.default
        let templates = try Bundle.module.url(forDirectory: "Templates")
        let currentDirectory = URL(fileURLWithPath: fileManager.currentDirectoryPath)

        let sourceOrigin = templates
            .appendingPathComponent("DayDD")
            .appendingPathExtension("swift")

        let sourceDestination = currentDirectory
            .appendingPathComponent("Year\(year)")
            .appendingPathComponent("Sources")
            .appendingPathComponent("Day\(dayString)")
            .appendingPathExtension("swift")

        let source = try String(contentsOf: sourceOrigin)
            .replacingOccurrences(of: "DayDD", with: "Day\(dayString)")
            .replacingOccurrences(of: "YearYYYY", with: "Year\(year)")

        try source.write(to: sourceDestination, atomically: true, encoding: .utf8)

        let testOrigin = templates
            .appendingPathComponent("DayDDTests")
            .appendingPathExtension("swift")

        let testDestination = currentDirectory
            .appendingPathComponent("Year\(year)")
            .appendingPathComponent("Tests")
            .appendingPathComponent("Day\(dayString)Tests")
            .appendingPathExtension("swift")

        let test = try String(contentsOf: testOrigin)
            .replacingOccurrences(of: "DayDD", with: "Day\(dayString)")
            .replacingOccurrences(of: "YearYYYY", with: "Year\(year)")

        try test.write(to: testDestination, atomically: true, encoding: .utf8)

//        let inputOrigin = templates
//            .appendingPathComponent("DayDDTests")
//            .appendingPathExtension("swift")
//
//        let inputDestination = currentDirectory
//            .appendingPathComponent("Year\(year)")
//            .appendingPathComponent("Tests")
//            .appendingPathComponent("Inputs")
//            .appendingPathComponent("Day\(dayString)")
//            .appendingPathExtension("txt")
//
//        try fileManager.copyItem(at: inputOrigin, to: inputDestination)
    }
}

extension Bundle {

    func url(forDirectory directory: String) throws -> URL {

        guard let directory = url(forResource: directory, withExtension: nil) else {
            struct CannotFindDirectory: Error {}
            throw CannotFindDirectory()
        }

        return directory
    }
}

extension Calendar {

    static let gregorian = Self(identifier: .gregorian)

    func value(for component: Calendar.Component, from date: Date) -> Int {
        dateComponents([component], from: date).value(for: component)!
    }
}
