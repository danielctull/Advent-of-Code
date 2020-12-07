
extension RawRepresentable {

    public init(_ rawValue: RawValue) throws {

        guard let value = Self(rawValue: rawValue) else {
            throw UnexpectedRawValue(rawValue: rawValue)
        }

        self = value
    }
}

fileprivate struct UnexpectedRawValue<RawValue>: Error {
    let rawValue: RawValue
}

extension UnexpectedRawValue: CustomStringConvertible {

    var description: String { #"Unexpected rawValue: "\(rawValue)"."# }
}
