
public protocol Dimension {
    associatedtype Index: CaseIterable
    associatedtype Scalar
    subscript(index: Index) -> Scalar { get }
}

// MARK: - 1D

public struct Dimension1<Scalar> {
    public let x: Scalar
}

extension Dimension1: Dimension {
    public struct Index: CaseIterable {
        public static var allCases: [Index] { [Index()] }
    }
    public subscript(index: Index) -> Scalar { x }
}

// MARK: - 2D

public struct Dimension2<Scalar> {
    public let x, y: Scalar
}

extension Dimension2: Dimension {
    public enum Index: CaseIterable {
        case x, y
    }
    public subscript(index: Index) -> Scalar {
        switch index {
        case .x: return x
        case .y: return y
        }
    }
}

// MARK: - 3D

public struct Dimension3<Scalar> {
    public let x, y, z: Scalar
}

extension Dimension3: Dimension {
    public enum Index: CaseIterable {
        case x, y, z
    }
    public subscript(index: Index) -> Scalar {
        switch index {
        case .x: return x
        case .y: return y
        case .z: return z
        }
    }
}

// MARK: - 4D

public struct Dimension4<Scalar> {
    public let w, x, y, z: Scalar
}

extension Dimension4: Dimension {
    public enum Index: CaseIterable {
        case w, x, y, z
    }
    public subscript(index: Index) -> Scalar {
        switch index {
        case .w: return w
        case .x: return x
        case .y: return y
        case .z: return z
        }
    }
}
