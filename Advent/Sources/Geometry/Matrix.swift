
import Foundation

fileprivate struct Size<Dimension> {
    let width: Dimension
    let height: Dimension
}

public struct Matrix<Element> {
    private let size: Size<Int>
    private let elements: [Element]
}

// MARK: - Creating a Matrix

extension Matrix {

    public init(elements: [[Element]]) {
        let width = elements[0].count
        let height = elements.count
        precondition(elements.allSatisfy { $0.count == width })
        self.size = Size(width: width, height: height)
        self.elements = elements.flatMap { $0 }
    }
}

extension Matrix
    where
    Element: RawRepresentable,
    Element.RawValue == Character
{
    public init(input: Input) throws {
        let elements = try input.lines.map { try $0.map { try Element($0) } }
        self.init(elements: elements)
    }
}

extension Matrix {

    public func map<T>(
        _ transform: (Position, Element) throws -> T
    ) rethrows -> Matrix<T> {
        Matrix<T>(size: size,
                  elements: try zip(indices, elements).map(transform))
    }
}

extension Matrix {

    fileprivate func validate(_ position: Position) -> Bool {
        guard position.x > 0 else { return false }
        guard position.y > 0 else { return false }
        guard position.x < endIndex.x else { return false }
        guard position.y < endIndex.y else { return false }
        return true
    }
}

// MARK: - Neighbours

extension Matrix {

    public func neighbours<S>(
        of position: Position,
        in directions: S
    ) -> [Position]
        where
        S: Sequence,
        S.Element == Vector<Int>
    {
        directions.map { position + $0 }.filter(validate)
    }

    public func positions(from position: Position, in direction: Vector<Int>) -> VectorSequence {
        VectorSequence(base: self, start: position, direction: direction)
    }

    public struct VectorSequence {
        let base: Matrix
        let start: Position
        let direction: Vector<Int>
    }
}

extension Matrix.VectorSequence: Sequence {

    public struct Iterator {
        let base: Matrix
        var position: Position
        let direction: Vector<Int>
    }

    public func makeIterator() -> Iterator {
        Iterator(base: base, position: start, direction: direction)
    }
}

extension Matrix.VectorSequence.Iterator: IteratorProtocol {

    public mutating func next() -> Matrix.Element? {
        position += direction
        guard base.validate(position) else { return nil }
        return base[position]
    }
}

// MARK: - Sequence

extension Matrix: Sequence {
    public func makeIterator() -> IndexingIterator<[Element]> {
        elements.makeIterator()
    }
}

extension Position: Comparable {
    public static func < (lhs: Position, rhs: Position) -> Bool {
        (lhs.y, lhs.x) < (rhs.y, rhs.x)
    }
}

// MARK: - Collection

extension Matrix: Collection {
    public typealias Index = Position
    public var startIndex: Position { Position(x: 0, y: 0) }
    public var endIndex: Position { Position(x: size.width, y: size.height) }

    public subscript(position: Position) -> Element {
        elements[position.y * size.width + position.x]
    }

    public func index(after position: Position) -> Position {

        if position.x + 1 < size.width {
            return Position(x: position.x + 1, y: position.y)
        }

        if position.y + 1 < size.height {
            return Position(x: 0, y: position.y + 1)
        }

        return endIndex
    }
}

// MARK: - CustomStringConvertible

extension Matrix: CustomStringConvertible
    where
    Element: CustomStringConvertible
{
    public var description: String {
        elements
            .split(length: size.width)
            .map { $0.map(\.description).joined() }
            .joined(separator: "\n")
    }
}
