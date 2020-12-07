
import Advent
import Foundation

public enum Day07 {

    public static func part1(_ input: Input) throws -> Int {

        try Array(bags: input.lines)
            .count(where: { $0.containsBag(named: "shiny gold") })
    }

    public static func part2(_ input: Input) -> Int {
        0
    }
}

extension Day07 {

    fileprivate class Bag {
        let name: String
        var contents: [Bag] = []
        init(name: String) { self.name = name }
    }
}

extension Day07.Bag {

    func containsBag(named name: String) -> Bool {
        contents.contains(where: {
            $0.name == name ||
            $0.containsBag(named: name)
        })
    }
}

extension Array where Element == Day07.Bag {

    fileprivate init(bags lines: [String]) throws {
        let name = try RegularExpression(pattern: "^([a-z ]+) bags contain")
        let contents = try RegularExpression(pattern: "([0-9]+) ([a-z ]+) bag")
        self.init()

        func findBag(named name: String) -> Day07.Bag {
            guard let bag = first(where: { $0.name == name }) else {
                let bag = Day07.Bag(name: name)
                append(bag)
                return bag
            }
            return bag
        }

        for line in lines {
            let name = try name.match(line).string(at: 0)
            let bag = findBag(named: name)

            bag.contents = try contents.matches(in: line)
                .map { findBag(named: try $0.string(at: 1)) }
        }
    }
}

extension Day07.Bag: CustomStringConvertible {
    var description: String { name }
}
