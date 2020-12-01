
import Foundation

public struct Input {

    public let lines: [String]
    public let testing: Bool
}

extension Bundle {

    func url(forDirectory directory: String) throws -> URL {

        guard let directory = url(forResource: directory, withExtension: nil) else {
            struct CannotFindDirectory: Error {}
            throw CannotFindDirectory()
        }

        return directory
    }

    public func input(named name: String, extension: String = "txt") throws -> Input {

        let url = try self.url(forDirectory: "Inputs")
            .appendingPathComponent(name)
            .appendingPathExtension(`extension`)

        return try Input(url: url)
    }
}

extension Input {
    public var integers: [Int] { lines.map { Int($0)! } }
}

extension Input {

    public init(url: URL) throws {

        struct Error: Swift.Error {}

        let data = try Data(contentsOf: url)
        guard let string = String(data: data, encoding: .utf8) else { throw Error() }

        testing = false
        lines = string
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }
}

extension Input: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: String...) {
        testing = true
        lines = elements
    }
}

extension Input: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        testing = true
        lines = value
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
    }
}
