
import Advent
import Foundation

public enum Day04 {

    public static func part1(_ input: Input) -> Int {
        input.lines
            .split(whereSeparator: { $0.isEmpty })
            .map { $0.joined(separator: " ") }
            .compactMap { try? Passport(string: $0) }
            .count
    }

    public static func part2(_ input: Input) -> Int {

        let validator = Validator<Passport>()
            .birthYear(.isWithin(1920...2002))
            .issueYear(.isWithin(2010...2020))
            .expirationYear(.isWithin(2020...2030))
            .height(.matches("^(1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in$"))
            .hairColor(.matches("^#[0-9a-f]{6}$"))
            .eyeColor(.isWithin("amb", "blu", "brn", "gry", "grn", "hzl", "oth"))
            .passportID(.matches("^[0-9]{9}$"))

        return input.lines
            .split(whereSeparator: { $0.isEmpty })
            .map { $0.joined(separator: " ") }
            .compactMap { try? Passport(string: $0) }
            .filter(validator.validate)
            .count
    }
}

extension Sequence where Element == Day04.Field {

    func field(for name: String) throws -> Day04.Field {
        guard let field = first(where: { $0.name == name }) else {
            throw Day04.FieldNotFound(name: name)
        }
        return field
    }
}

extension Day04 {

    fileprivate struct FieldNotFound: Error {
        let name: String
    }

    fileprivate struct Field {
        let name: String
        let value: String
    }

    fileprivate struct Passport {

        init(string: String) throws {
            let regex = try RegularExpression(pattern: "([^: ]+):([^: ]+)")
            let fields = try regex.matches(in: string)
                .map { try Field(name: $0.string(at: 0), value: $0.string(at: 1)) }

            birthYear = try Int(fields.field(for: "byr").value)
            issueYear = try Int(fields.field(for: "iyr").value)
            expirationYear = try Int(fields.field(for: "eyr").value)
            height = try fields.field(for: "hgt").value
            hairColor = try fields.field(for: "hcl").value
            eyeColor = try fields.field(for: "ecl").value
            passportID = try fields.field(for: "pid").value
            countryID = try? fields.field(for: "cid").value
        }

        let birthYear: Int // byr (Birth Year)
        let issueYear: Int // iyr (Issue Year)
        let expirationYear: Int // eyr (Expiration Year)
        let height: String // hgt (Height)
        let hairColor: String // hcl (Hair Color)
        let eyeColor: String // ecl (Eye Color)
        let passportID: String // pid (Passport ID)
        let countryID: String? // cid (Country ID)
    }
}
