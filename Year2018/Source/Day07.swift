
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

    public func part2(input: Input, workers: Int, baseTime: Int) -> Int {

        func time(_ string: String) -> Int {
            let base = Int(("A" as UnicodeScalar).value)
            let value = Int((UnicodeScalar(string)!).value)
            return value - (base - 1) + baseTime
        }


        return input
            .lines
            .map { $0.string }
            .reduce(into: DependencyGraph<String>()) { graph, string in

                let components = string.components(separatedBy: " ")
                let dependency = components[1]
                let value = components[7]
                graph.addDependency(dependency, to: value)
            }
            .parallelized(workers: workers, time: time)
            .count
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

extension DependencyGraph {

    struct Worker {
        let number: Int
        var task: Task?

        init(number: Int) {
            self.number = number
        }
    }

    struct Task: Hashable {
        let value: Value
        var time: Int
    }

    func parallelized(workers numberOfWorkers: Int, time: (Value) -> Int) -> [String] {

        var result: [String] = []
        var completed: [Value] = []
        var workers: [Worker] = (0..<numberOfWorkers).map { Worker(number: $0 + 1) }
        var dependencies = self.dependencies

        while dependencies.count > 0 {

            // Decrease task times

            workers = workers.map {
                var worker = $0
                worker.task?.time -= 1
                return worker
            }

            // Determine completed tasks

            completed += workers
                .compactMap { $0.task }
                .filter { $0.time == 0 }
                .map { $0.value }

            // Remove completed tasks

            workers = workers.map {

                guard let task = $0.task else { return $0 }

                guard task.time == 0 else { return $0 }

                var worker = $0
                worker.task = nil
                return worker
            }

            // Sort out dependencies

            dependencies = dependencies
                .filter { !completed.contains($0.key) }
                .mapValues { $0.filter { !completed.contains($0) } }

            guard dependencies.count > 0 else { continue }

            // Work out what comes next

            var nextValues = dependencies
                .filter { $0.value.count == 0 }
                .map { $0.key }
                .filter { !workers.compactMap { $0.task?.value }.contains($0) }
                .sorted()
                .makeIterator()

            // Assign workers

            workers = workers.map {

                guard
                    $0.task == nil,
                    let nextValue = nextValues.next()
                else {
                    return $0
                }

                var worker = $0
                worker.task = Task(value: nextValue, time: time(nextValue))
                return worker
            }

            // Add to the working log

            let description = workers.map { String(describing: $0) }.joined(separator: "     ")

//            print(description)
            result.append(description)
        }

        return result
    }
}

extension DependencyGraph.Worker: CustomStringConvertible {

    var description: String {

        guard let task = task else {
            return "#\(number): ."
        }

        return "#\(number): \(String(describing: task.value))"
    }
}
