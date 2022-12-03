
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
        let ascii = try characters.map(Int.ascii)
        computer.input(ascii)
    }

    public mutating func input(_ character: Character) throws {
        let ascii = try Int.ascii(character)
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
