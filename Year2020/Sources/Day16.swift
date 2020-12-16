
import Advent
import Foundation

public enum Day16: Day {

    public static let title = "Ticket Translation"

    public static func part1(_ input: Input) throws -> Int {

        let sections = input.lines.split(whereSeparator: \.isEmpty)

        let rules = try Array(rules: sections[0])
            .map(\.valid)
            .joined(operator: ||)

        let values = try sections[2]
            .dropFirst()
            .joined(separator: ",")
            .split(separator: ",")
            .map(Int.init)

        return values
            .filter(!rules)
            .sum()
    }

    public static func part2(_ input: Input) throws -> Int {

        let sections = input.lines.split(whereSeparator: \.isEmpty)
        let rules = try Array(rules: sections[0])
        let yourTicket = try Array(tickets: sections[1]).first.unwrapped()
        let nearbyTickets = try Array(tickets: sections[2])
        let fieldCount = yourTicket.fields.count

        let anyRule = rules
            .map(\.valid)
            .joined(operator: ||)

        return try nearbyTickets

            // Remove invalid tickets.
            .filter { $0.fields.allSatisfy(anyRule) }

            // Take the rules and repeat them for the amount of fields, then
            // reduce them by removing any which aren't valid for the field of
            // each ticket.
            .reduce(rules.repeating(fieldCount)) { potentialRules, ticket in
                zip(potentialRules, ticket.fields)
                    .map { rules, field in
                        rules.filter { $0.valid(field) }
                    }
            }

            // Order them by number of potential rules so the ones with the
            // fewest will be looked at first.
            .enumerated()
            .sorted(by: { $0.element.count < $1.element.count })

            // Move along the [[Rule]] and pick the first where the rules aren't
            // already used for a previous field.
            .reduce(into: Array<(Int, Rule)>()) { rules, potential in

                let rule = try potential
                    .element
                    .first(where: { rule in !rules.contains { $0.1 == rule }})
                    .unwrapped()

                rules.append((potential.offset, rule))
            }

            // Find the rules that have the "depature" prefix and multiply the
            // fields in your ticket.
            .filter { $0.1.name.hasPrefix("departure") }
            .map { yourTicket.fields[$0.0] }
            .product()
    }
}

extension Day16 {

    fileprivate struct Ticket {
        let fields: [Int]
    }

    fileprivate struct Rule {
        let name: String
        let valid: Predicate<Int>
    }
}

extension Day16.Rule: Equatable {
    static func == (lhs: Day16.Rule, rhs: Day16.Rule) -> Bool {
        lhs.name == rhs.name
    }
}

extension Day16.Rule: CustomStringConvertible {
    var description: String { "Rule: \(name)" }
}

extension Array where Element == Day16.Rule {

    fileprivate init<S>(rules: S) throws where S: Sequence, S.Element == String {
        let regex = try RegularExpression(pattern: "^([a-z ]+): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)")
        self = try rules.map { string in
            let match = try regex.match(string)
            let lower1 = try match.integer(at: 1)
            let upper1 = try match.integer(at: 2)
            let lower2 = try match.integer(at: 3)
            let upper2 = try match.integer(at: 4)
            return Day16.Rule(
                name: try match.string(at: 0),
                valid: .isWithin(lower1...upper1) || .isWithin(lower2...upper2))
        }
    }
}

extension Array where Element == Day16.Ticket {

    fileprivate init<S>(tickets: S) throws where S: Sequence, S.Element == String {

        self = try tickets
            .dropFirst()
            .map { string in

                Day16.Ticket(
                    fields: try string.split(separator: ",")
                        .map(Int.init))
            }
    }
}
