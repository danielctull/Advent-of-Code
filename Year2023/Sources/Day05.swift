
import Advent
import Algorithms
import Foundation
import RegexBuilder

public enum Day05: Day {

    public static let title = "If You Give A Seed A Fertilizer"

    public static func part1(_ input: Input) throws -> Int {
        let output = try regex.match(in: input.string).output
        let seeds: [Int] = output.1.map(\.1)
        let mappings: [Mapping] = output.2.map(\.1).map(Mapping.init)

        return try mappings
            .reduce(seeds) { seeds, mapping in seeds.map { mapping.destination(for: $0) } }
            .min
    }

    public static func part2(_ input: Input) throws -> Int {
        let output = try regex.match(in: input.string).output
        let seeds: [Int] = try output.1.map(\.1)
            .chunks(ofCount: 2)
            .flatMap {
                let start = try $0.first.unwrapped
                let range = try $0.last.unwrapped
                return start..<start+range
            }
        let mappings: [Mapping] = output.2.map(\.1).map(Mapping.init)

        print("Steps:", mappings.count)
        var step = 0

        return try mappings
            .reduce(seeds) { seeds, mapping in
                print("Step:", step); step += 1
                return Set(seeds).map { mapping.destination(for: $0) }
            }
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
        groups = output.map { Group(destination: $0.1, source: $0.2, range: $0.3) }
    }

    func destination(for source: Int) -> Int {
        guard let group = groups.first(where: { $0.source.contains(source) }) else { return source }
        let difference = group.destination.lowerBound - group.source.lowerBound
        return source + difference
    }

    struct Group {
        let source: Range<Int>
        let destination: Range<Int>

        init(destination: Int, source: Int, range: Int) {
            self.source = source..<source+range
            self.destination = destination..<destination+range
        }
    }
}
