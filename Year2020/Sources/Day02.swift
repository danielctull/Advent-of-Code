
import Advent
import Foundation

public enum Day02 {

    public static func part1(_ input: Input) throws -> Int {

        try input.lines
            .map(Line.init)
            .filter { $0.rule.validate($0.password) }
            .count
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day02.Rule {

    func validate(_ password: Day02.Password) -> Bool {
        let count = password.rawValue.filter { $0 == character }.count
        return amount.contains(count)
    }
}

extension Day02 {

    fileprivate struct Line {
        let rule: Rule
        let password: Password
    }

    fileprivate struct Password: RawRepresentable {
        let rawValue: String
    }

    fileprivate struct Rule {
        let amount: ClosedRange<Int>
        let character: Character
    }
}

extension Day02.Line {

    init(_ string: String) throws {
        let parts = string.split(separator: ":")
        rule = try Day02.Rule(parts[0])
        password = try Day02.Password(String(parts[1]))
    }
}

extension Day02.Rule {

    init<S: StringProtocol>(_ string: S) throws {
        let parts = string.split(separator: " ")
        character = Character(String(parts[1]))
        amount = try ClosedRange(parts[0])
    }
}

extension ClosedRange where Bound == Int {

    fileprivate init<S: StringProtocol>(_ string: S) throws {
        let parts = string.split(separator: "-")
        self = try Int(parts[0])...Int(parts[1])
    }
}
