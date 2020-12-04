
import Advent
import Year2020
import XCTest

final class Day04Tests: XCTestCase {

    func testPart1Examples() throws {
        XCTAssertEqual(Day04.part1([
            "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd",
            "byr:1937 iyr:2017 cid:147 hgt:183cm",
            "",
            "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884",
            "hcl:#cfa07d byr:1929",
            "",
            "hcl:#ae17e1 iyr:2013",
            "eyr:2024",
            "ecl:brn pid:760753108 byr:1931",
            "hgt:179cm",
            "",
            "hcl:#cfa07d eyr:2025 pid:166559648",
            "iyr:2011 ecl:brn hgt:59in"
        ]), 2)
    }

    func testPart1Puzzle() throws {
        let input = try Bundle.module.input(named: "Day04")
        XCTAssertEqual(Day04.part1(input), 202)
    }

    func testPart2Examples() throws {
        let height = RegularExpression.Pattern("^(?:1[5-8][0-9]|19[0-3])cm|(?:59|6[0-9]|7[0-6])in$")
        XCTAssertTrue(Predicate.matches(height)("60in"))
        XCTAssertTrue(Predicate.matches(height)("190cm"))
        XCTAssertFalse(Predicate.matches(height)("190in"))
        XCTAssertFalse(Predicate.matches(height)("190"))

        let hair = RegularExpression.Pattern("^#[0-9a-f]{6}$")
        XCTAssertTrue(Predicate.matches(hair)("#123abc"))
        XCTAssertFalse(Predicate.matches(hair)("#123abz"))
        XCTAssertFalse(Predicate.matches(hair)("123abc"))

        let passportID = RegularExpression.Pattern("^[0-9]{9}$")
        XCTAssertTrue(Predicate.matches(passportID)("000000001"))
        XCTAssertFalse(Predicate.matches(passportID)("0123456789"))
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day04")
        XCTAssertEqual(Day04.part2(input), 137)
    }
}
