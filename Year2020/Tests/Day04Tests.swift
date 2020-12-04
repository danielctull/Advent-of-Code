
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
        XCTAssertEqual(Day04.part2("1721,979,366,299,675,1456"), 0)
    }

    func testPart2Puzzle() throws {
        let input = try Bundle.module.input(named: "Day01")
        XCTAssertEqual(Day04.part2(input), 0)
    }
}
