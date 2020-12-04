
import Advent
import Foundation

public enum Day04 {

    public static func part1(_ input: Input) throws -> Int {
        try passports(for: input).count
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }

    private static func passports(for input: Input) throws -> [Passport] {

        input.lines
            .reduce(into: [String]()) { result, line in

                guard line.count > 0 else {
                    // Start new passport
                    result.append("")
                    return
                }

                var passport = result.last ?? ""
                passport.append(" ")
                passport.append(line)

                if result.count > 0 {
                    result[result.endIndex - 1] = passport
                } else {
                    result.append(passport)
                }
            }
            .compactMap {
                do { return try Passport(string: $0) }
                catch { return nil }
            }
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

            birthYear = try fields.field(for: "byr").value
            issueYear = try fields.field(for: "iyr").value
            expirationYear = try fields.field(for: "eyr").value
            height = try fields.field(for: "hgt").value
            hairColor = try fields.field(for: "hcl").value
            eyeColor = try fields.field(for: "ecl").value
            passportID = try fields.field(for: "pid").value
            countryID = try? fields.field(for: "cid").value
        }

        let birthYear: String // byr (Birth Year)
        let issueYear: String // iyr (Issue Year)
        let expirationYear: String // eyr (Expiration Year)
        let height: String // hgt (Height)
        let hairColor: String // hcl (Hair Color)
        let eyeColor: String // ecl (Eye Color)
        let passportID: String // pid (Passport ID)
        let countryID: String? // cid (Country ID)
    }
}
