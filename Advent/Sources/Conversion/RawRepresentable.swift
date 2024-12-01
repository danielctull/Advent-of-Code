
extension RawRepresentable where RawValue: Sendable {

    public init(_ rawValue: RawValue) throws {

        guard let value = Self(rawValue: rawValue) else {
            throw UnexpectedRawValue(rawValue: rawValue)
        }

        self = value
    }
}

public struct UnexpectedRawValue<RawValue: Sendable>: Error {
    let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
}

extension UnexpectedRawValue: CustomStringConvertible {

    public var description: String { #"Unexpected rawValue: "\#(rawValue)"."# }
}
