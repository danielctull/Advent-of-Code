
// Bit at index 0 is least significant bit.
public struct BinaryNumber {
    private var bits: [Bit]
    public init(bits: [Bit]) {
        self.bits = bits.reversed()
    }
    public init(_ bits: Bit...) {
        self.init(bits: bits)
    }
}

extension BinaryNumber: CustomStringConvertible {
    public var description: String {
        String(reversed().map {
            switch $0 {
            case .zero: return "0"
            case .one: return "1"
            }
        })
    }
}

extension BinaryNumber {
    public init(_ value: Int) {
        self.init(bits: String(value, radix: 2).map {
            switch $0 {
            case "0": return .zero
            case "1": return .one
            default: fatalError()
            }
        })
    }
}

extension BinaryNumber: Sequence {
    public func makeIterator() -> IndexingIterator<[Bit]> {
        bits.makeIterator()
    }
}

extension BinaryNumber: Collection {

    public struct Index: Comparable {
        public static func < (lhs: Index, rhs: Index) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        init(_ value: Int) { rawValue = value }
        fileprivate let rawValue: Int
    }

    public var startIndex: Index { Index(bits.startIndex) }
    public var endIndex: Index { Index(bits.endIndex) }
    public func index(after i: Index) -> Index { Index(bits.index(after: i.rawValue)) }
    public subscript(position: Index) -> Bit {
        get { bits[position.rawValue] }
        set {
            while position.rawValue >= bits.count { bits.append(.zero) }
            bits[position.rawValue] = newValue
        }
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
        self = binaryNumber.reversed().reduce(0) { $0 * 2 + Int($1) }
    }
}
