
import Foundation

struct NotInteger: LocalizedError {
    let value: String
    var errorDescription: String? { "Expected integer but received \(value)." }
}

extension Int {

    public init(_ string: String) throws {
        guard let int = Int.init(string) else { throw NotInteger(value: string) }
        self = int
    }

    public init(_ character: Character) throws {
        try self.init(String(character))
    }
}

extension Int {

    public static func ascii(_ character: Character) throws -> Int {

        struct NotASCII: Error {
            let character: Character
        }

        guard let ascii = character.asciiValue else {
            throw NotASCII(character: character)
        }

        return Int(ascii)
    }
}
