
import Foundation

public struct Input {

    public let lines: [Line]
    public let testing: Bool
}

extension Input {

    public struct Line {

        public let string: String
    }
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
            .map(Line.init)
    }
}

extension Input: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: String...) {
        testing = true
        lines = elements.map(Line.init)
    }
}

extension Input: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        testing = true
        lines = value
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .map(Line.init)
    }
}
