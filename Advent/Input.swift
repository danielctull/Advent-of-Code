
import Foundation

public struct Input {

    public let lines: [Line]
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

        lines = string.components(separatedBy: .newlines).map(Line.init)
    }
}

extension Input: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: String...) {
        lines = elements.map(Line.init)
    }
}

extension Input: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {

        lines = value
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .map(Line.init)
    }
}
