
import Advent
import Foundation

public struct Day08 {

    public init() {}

    public func part1(input: Input) -> Int {

        var values = input
            .lines
            .first!
            .string
            .components(separatedBy: " ")
            .map { Int($0)! }
            .makeIterator()

        func fetchMetadata<I: IteratorProtocol>(using iterator: inout I) -> [Int] where I.Element == Int {

            let childrenCount = iterator.next()!
            let metadataCount = iterator.next()!

            let childrenMetadata = (0..<childrenCount).flatMap { _ in
                fetchMetadata(using: &iterator)
            }

            let metadata = (0..<metadataCount).map { _ in
                iterator.next()!
            }

            return metadata + childrenMetadata
        }

        return fetchMetadata(using: &values).reduce(0, +)
    }

    public func part2(input: Input) -> Int {
        return 0
    }
}
