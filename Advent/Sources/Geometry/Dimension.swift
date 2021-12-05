
public protocol Dimension {
    associatedtype Parameter: CaseIterable
    associatedtype Scalar
    init(value: (Parameter) -> Scalar)
    subscript(parameter: Parameter) -> Scalar { get }
}

// MARK: - 2D

public struct Dimension2<Scalar> {
    public let x, y: Scalar
}

extension Dimension2: Dimension {
    public enum Parameter: CaseIterable {
        case x, y
    }
    public init(value: (Parameter) -> Scalar) {
        x = value(.x)
        y = value(.y)
    }
    public subscript(parameter: Parameter) -> Scalar {
        switch parameter {
        case .x: return x
        case .y: return y
        }
    }
}

extension Dimension2: Equatable where Scalar: Equatable {}
extension Dimension2: Hashable where Scalar: Hashable {}

extension Dimension2: CustomStringConvertible {
    public var description: String { "x: \(x), y: \(y)" }
}

// MARK: - 3D

public struct Dimension3<Scalar> {
    public let x, y, z: Scalar
}

extension Dimension3: Dimension {
    public enum Parameter: CaseIterable {
        case x, y, z
    }
    public init(value: (Parameter) -> Scalar) {
        x = value(.x)
        y = value(.y)
        z = value(.z)
    }
    public subscript(parameter: Parameter) -> Scalar {
        switch parameter {
        case .x: return x
        case .y: return y
        case .z: return z
        }
    }
}

extension Dimension3: Equatable where Scalar: Equatable {}
extension Dimension3: Hashable where Scalar: Hashable {}

// MARK: - 4D

public struct Dimension4<Scalar> {
    public let w, x, y, z: Scalar
}

extension Dimension4: Dimension {
    public enum Parameter: CaseIterable {
        case w, x, y, z
    }
    public init(value: (Parameter) -> Scalar) {
        w = value(.w)
        x = value(.x)
        y = value(.y)
        z = value(.z)
    }
    public subscript(parameter: Parameter) -> Scalar {
        switch parameter {
        case .w: return w
        case .x: return x
        case .y: return y
        case .z: return z
        }
    }
}

extension Dimension4: Equatable where Scalar: Equatable {}
extension Dimension4: Hashable where Scalar: Hashable {}
