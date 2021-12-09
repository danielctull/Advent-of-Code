
import Advent
import Algorithms
import Foundation

public enum Day09: Day {

    public static let title = "Smoke Basin"

    public static func part1(_ input: Input) throws -> Int {

        let matrix = try Matrix(input: input, element: Int.init)

        return matrix
            .map { (position: Position2D, value: Int) -> Int in

                position
                    .orthogonallyAdjacent
                    .compactMap { matrix[$0] }
                    .allSatisfy { value < $0 }
                        ? value + 1
                        : 0
            }
            .sum
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
