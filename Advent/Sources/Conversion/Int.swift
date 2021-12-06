
extension Int {

    public init(_ character: Character) throws {
        self = try Int(String(character)).unwrapped
    }
}
