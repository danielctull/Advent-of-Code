
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
                  elements: try zip(positions, elements).map(transform))
    }
}

// MARK: - Accessing values

extension Matrix {

    public subscript(position: Position) -> Element? {
        guard position.x >= 0 else { return nil }
        guard position.y >= 0 else { return nil }
        guard position.x < size.width else { return nil }
        guard position.y < size.height else { return nil }
        return elements[position.y * size.width + position.x]
    }

    public var positions: UnfoldFirstSequence<Position> {
        sequence(first: .origin) { previous -> Position? in
            if previous.x + 1 < size.width {
                return Position(x: previous.x + 1, y: previous.y)
            }
            if previous.y + 1 < size.height {
                return Position(x: 0, y: previous.y + 1)
            }
            return nil
        }
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
    public typealias Index = Int
    public var startIndex: Index { elements.startIndex }
    public var endIndex: Index { elements.endIndex }
    public subscript(position: Int) -> Element { elements[position] }
    public func index(after i: Index) -> Index { elements.index(after: i) }
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
