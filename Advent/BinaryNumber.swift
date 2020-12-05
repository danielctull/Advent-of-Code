
public struct BinaryNumber {
    private let bits: [Bit]
    public init(bits: [Bit]) {
        self.bits = bits
    }
}

extension BinaryNumber: Sequence {
    public func makeIterator() -> IndexingIterator<[Bit]> {
        bits.makeIterator()
    }
}

public enum Bit {
    case zero
    case one
}

extension Int {

    public init(_ bit: Bit) {
        switch bit {
        case .zero: self = 0
        case .one: self = 1
        }
    }

    public init(_ binaryNumber: BinaryNumber) {
        self = binaryNumber.reduce(0) { $0 * 2 + Int($1) }
    }
}
