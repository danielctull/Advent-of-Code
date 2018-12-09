
import Advent
import Foundation

public struct Day07 {

    public init() {}

    public func part1(input: Input) -> String {

        return input
            .lines
            .map { $0.string }
            .reduce(into: DependencyGraph<String>()) { graph, string in

            let components = string.components(separatedBy: " ")
            let dependency = components[1]
            let value = components[7]
            graph.addDependency(dependency, to: value)
        }
            .serialized
            .reduce("", +)
    }

    public func part2(input: Input) -> Int {
        return 0
    }
}

struct DependencyGraph<Value: Hashable & Comparable & Equatable> {

//    private var values: Set<Value> = []
    private var dependencies: [Value: [Value]] = [:]

    mutating func addDependency(_ dependency: Value, to value: Value) {
        dependencies[dependency, default: []] += []
        dependencies[value, default: []] += [dependency]
    }
}

extension DependencyGraph {

    var serialized: [Value] {

        var result: [Value] = []
        var dependencies = self.dependencies

        while dependencies.count > 0 {

            let next = dependencies
                .filter { $0.value.count == 0 }
                .map { $0.key }
                .sorted()
                .first!

            result.append(next)

            dependencies = dependencies
                .filter { !result.contains($0.key) }
                .mapValues { $0.filter { !result.contains($0) } }
        }

        return result
    }
}
