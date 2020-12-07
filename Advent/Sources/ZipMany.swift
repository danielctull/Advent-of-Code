
extension Sequence where Element: Sequence {
    public var zipped: ZipMany<Self> { ZipMany(base: self) }
}

public struct ZipMany<Base> where Base: Sequence, Base.Element: Sequence {
    let base: Base
}

extension ZipMany: Sequence {

    public func makeIterator() -> Iterator {
        Iterator(base: base.map { $0.makeIterator() })
    }
}

extension ZipMany {

    public struct Iterator {
        let index = 0
        var base: [Base.Element.Iterator]
    }
}

extension ZipMany.Iterator: IteratorProtocol {

    public mutating func next() -> [Base.Element.Element]? {

        var elements: [Base.Element.Element] = []
        for index in base.indices {
            var iterator = base[index]
            if let element = iterator.next() {
                elements.append(element)
            }
            base[index] = iterator
        }

        guard elements.count == base.count else { return nil }
        return elements
    }
}
