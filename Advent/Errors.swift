
public struct UnexpectedCharacter: Error {
    public let character: Character
    public init(_ character: Character) {
        self.character = character
    }
}
