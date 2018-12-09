
import Advent
import Foundation

public struct Day08 {

    public init() {}

    public func part1(input: Input) -> Int {

        var iterator = input
            .lines
            .first!
            .string
            .components(separatedBy: " ")
            .map { Int($0)! }
            .makeIterator()

        func fetchMetadata() -> [Int] {

            let childrenCount = iterator.next()!
            let metadataCount = iterator.next()!

            let childrenMetadata = (0..<childrenCount).flatMap { _ in
                fetchMetadata()
            }

            let metadata = (0..<metadataCount).map { _ in
                iterator.next()!
            }

            return metadata + childrenMetadata
        }

        return fetchMetadata().reduce(0, +)
    }

    public func part2(input: Input) -> Int {

        var iterator = input
            .lines
            .first!
            .string
            .components(separatedBy: " ")
            .map { Int($0)! }
            .makeIterator()

        func fetchValue() -> Int {

            let childrenCount = iterator.next()!
            let metadataCount = iterator.next()!

            let childrenMetadata = (0..<childrenCount).map { _ in
                fetchValue()
            }

            let metadata = (0..<metadataCount).map { _ in
                iterator.next()!
            }

            guard childrenCount > 0 else {
                return metadata.reduce(0, +)
            }

            return metadata.map {

                let index = $0 - 1

                guard index >= 0, index < childrenMetadata.count else {
                    return 0
                }

                return childrenMetadata[index]

            }.reduce(0, +)
        }

        return fetchValue()
    }
}
