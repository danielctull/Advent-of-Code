
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
        _ transform: (Position<Int>, Element) throws -> T
    ) rethrows -> Matrix<T> {
        Matrix<T>(size: size,
                  elements: try zip(positions, elements).map(transform))
    }

    public func map<T>(
        _ transform: (Index, Element) throws -> T
    ) rethrows -> Matrix<T> {
        Matrix<T>(size: size,
                  elements: try zip(indices, elements).map(transform))
    }
}

// MARK: - Accessing values

extension Matrix {

    public subscript(position: Position<Int>) -> Element? {
        guard position.x >= 0 else { return nil }
        guard position.y >= 0 else { return nil }
        guard position.x < size.width else { return nil }
        guard position.y < size.height else { return nil }
        return self[Index(position: position)]
    }

    public var positions: [Position<Int>] { indices.map(\.position) }
}

// MARK: - Neighbours

extension Matrix {

    public func indices(from index: Index, in direction: Vector<Int>) -> VectorSequence {
        VectorSequence(base: self, start: index, direction: direction)
    }

    public struct VectorSequence {
        let base: Matrix
        let start: Index
        let direction: Vector<Int>
    }
}

extension Matrix.VectorSequence: Sequence {

    public struct Iterator {
        let base: Matrix
        var previous: Matrix.Index
        let direction: Vector<Int>
    }

    public func makeIterator() -> Iterator {
        Iterator(base: base, previous: start, direction: direction)
    }
}

extension Matrix.VectorSequence.Iterator: IteratorProtocol {

    public mutating func next() -> Matrix.Element? {
        let next = previous.position + direction
        guard let element = base[next] else { return nil }
        previous = Matrix.Index(position: next)
        return element
    }
}


// MARK: - Sequence

extension Matrix: Sequence {
    public func makeIterator() -> IndexingIterator<[Element]> {
        elements.makeIterator()
    }
}

// MARK: - Collection

extension Matrix: Collection {

    public struct Index: Comparable {
        let position: Position<Int>
        public static func < (lhs: Index, rhs: Index) -> Bool {
            (lhs.position.y, lhs.position.x) < (rhs.position.y, rhs.position.x)
        }
    }

    public var startIndex: Index {
        Index(position: Position(x: 0, y: 0))
    }

    public var endIndex: Index {
        Index(position: Position(x: size.width, y: size.height))
    }

    public subscript(i: Index) -> Element {
        elements[i.position.y * size.width + i.position.x]
    }

    public func index(after i: Index) -> Index {

        if i.position.x + 1 < size.width {
            return Index(position: Position(x: i.position.x + 1, y: i.position.y))
        }
        if i.position.y + 1 < size.height {
            return Index(position: Position(x: 0, y: i.position.y + 1))
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
