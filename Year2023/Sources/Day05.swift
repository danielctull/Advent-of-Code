
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day05: Day {

    public static let title = "If You Give A Seed A Fertilizer"

    public static func part1(_ input: Input) throws -> Int {
        let output = try regex.match(in: input.string).output
        let seeds: [Int] = output.1
        let mappings: [Mapping] = output.2.map(Mapping.init)

        return try mappings
            .reduce(seeds) { seeds, mapping in seeds.map { mapping.destination(for: $0) } }
            .min
    }

    public static func part2(_ input: Input) throws -> Int {
        let output = try regex.match(in: input.string).output
        let seeds: [Range<Int>] = try output.1
            .chunks(ofCount: 2)
            .map {
                let start = try $0.first.unwrapped
                let range = try $0.last.unwrapped
                return start..<start+range
            }
        let mappings: [Mapping] = output.2.map(Mapping.init)

        return try mappings
            .reduce(seeds) { seeds, mapping in
                seeds.flatMap { mapping.destinations(for: $0) }
            }
            .map(\.lowerBound)
            .min
    }

    public static let regex = Regex {
        
        "seeds:"
        Capture {
            List {
                OneOrMore(.whitespace)
                TryCapture.integer
            }
        }
        Capture {
            List {
                One(.newlineSequence)
                One(.newlineSequence)
                OneOrMore(.anyNonNewline)

                Capture {
                    List {
                        One(.newlineSequence)
                        TryCapture.integer
                        OneOrMore(.whitespace)
                        TryCapture.integer
                        OneOrMore(.whitespace)
                        TryCapture.integer
                    }
                }
            }
        }
    }
}

fileprivate struct Mapping {

    let groups: [Group]

    init(_ output: [(Substring, Int, Int, Int)]) {
        groups = output.map {
            Group(destination: $0.1, source: $0.2, range: $0.3)
        }
    }

    func destination(for source: Int) -> Int {
        let destination = groups
            .lazy
            .compactMap { $0.destination(for: source) }
            .first
        return destination ?? source
    }

    func destinations(for source: Range<Int>) -> [Range<Int>] {
        var sources = [source]
        var mapped: [Range<Int>] = []
        for group in groups {
            sources = sources.flatMap { source in
                let (intersection, remainder) = group.source.intersection(source)
                if let intersection, let destination = group.destination(for: intersection) {
                    mapped.append(destination)
                }
                return remainder
            }
        }
        mapped.append(contentsOf: sources)
        return mapped
    }

    struct Group {
        let source: Range<Int>
        private let destination: Range<Int>
        private let difference: Int

        init(destination: Int, source: Int, range: Int) {
            self.source = source..<source+range
            self.destination = destination..<destination+range
            difference = destination - source
        }

        func destination(for value: Int) -> Int? {
            guard source.contains(value) else { return nil }
            return value + difference
        }

        func destination(for range: Range<Int>) -> Range<Int>? {
            guard source.contains(range) else { return nil }
            return (range.lowerBound + difference)..<(range.upperBound + difference)
        }
    }
}
