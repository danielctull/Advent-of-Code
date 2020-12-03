
import Advent
import Algorithms
import Foundation

public enum Day03 {

    public static func part1(_ input: Input) throws -> Int {
        count(input: input, right: 3, down: 1)
    }

    public static func part2(_ input: Input) throws -> Int {
        let slopes: [SIMD2<Int>] = [
            [1, 1],
            [3, 1],
            [5, 1],
            [7, 1],
            [1, 2]
        ]
        let forest = Forest(rows: input.lines)
        let counts = slopes.lazy.map { forest.numberOfTrees(following: $0) }
        return counts.reduce(1, *)
    }

    private static func count(input: Input, right: Int, down: Int) -> Int {
        let columns = (0...).striding(by: right)
        let rows = input.lines.striding(by: down)
        return zip(columns, rows).count(where: { column, row in
            row[row.index(row.startIndex, offsetBy: column % row.count)] == "#"
        })
    }
}

struct Forest {

    init(rows: [String]) {
        self.rows = rows
        self.rowWidth = rows[0].count
    }

    let rows: [String]
    let rowWidth: Int

    /// The number of trees encountered if taking `slope`, starting from top left.
    func numberOfTrees(following slope: SIMD2<Int>) -> Int {
        let strideX = stride(from: 0, to: .max, by: slope.x)
        let strideY = stride(from: self.rows.startIndex, to: self.rows.endIndex, by: slope.y)

        return zip(strideX, strideY).count(where: { x, y in
            let row = rows[y]
            return row[row.index(row.startIndex, offsetBy: x % rowWidth)] == "#"
        })
    }
}
