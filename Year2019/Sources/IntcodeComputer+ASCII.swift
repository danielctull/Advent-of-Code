
extension IntcodeComputer {

    public struct ASCII {
        fileprivate var computer: IntcodeComputer
    }

    public var ascii: ASCII {
        get { ASCII(computer: self) }
        set { self = newValue.computer }
    }
}

extension IntcodeComputer.ASCII {

    public mutating func input<S>(_ characters: S) throws
        where S: Sequence,
        S.Element == Character
    {
        let ascii = try characters.map(Int.init(asciiCharacter:))
        computer.input(ascii)
    }

    public mutating func input(_ character: Character) throws {
        let ascii = try Int(asciiCharacter: character)
        computer.input(ascii)
    }

    public var output: String {
        String(ascii: computer.output)
    }

    public mutating func nextOutput() -> String {
        String(ascii: computer.nextOutput())
    }
}

extension String {

    fileprivate init(ascii: [Int]) {
        let characters = ascii
            .compactMap(UnicodeScalar.init)
            .map(Character.init)
        self.init(characters)
    }
}

extension Int {

    fileprivate init(asciiCharacter: Character) throws {

        struct NotASCII: Error {
            let character: Character
        }

        guard let ascii = asciiCharacter.asciiValue else {
            throw NotASCII(character: asciiCharacter)
        }

        self = Int(ascii)
    }
}
