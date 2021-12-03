
import Advent
import Algorithms
import Foundation

public enum Day03: Day {

    public static let title = "Binary Diagnostic"

    public static func part1(_ input: Input) throws -> Int {
        try input.lines
            .map(BinaryNumber.init)
            .reduce(into: Count()) { $0.count($1) }
            .result
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}

extension Day03 {

    fileprivate struct Count {
        var zeros: [Int] = []
        var ones: [Int] = []
    }
}

extension Day03.Count {

    mutating func count(_ binary: BinaryNumber) {
        if zeros.count == 0 { zeros = Array(repeating: 0, count: binary.count) }
        if ones.count == 0 { ones = Array(repeating: 0, count: binary.count) }

        self = binary.indexed().reduce(into: self) { (count, argument) in
            let (index, bit) = argument
            switch bit {
            case .one: count.ones[index] += 1
            case .zero: count.zeros[index] += 1
            }
        }
    }

    var result: Int { Int(gamma) * Int(epsilon) }

    var gamma: BinaryNumber {
        BinaryNumber(bits: zip(zeros, ones).map { $0 < $1 ? .zero : .one })
    }

    var epsilon: BinaryNumber { !gamma }
}
