
import Advent
import Foundation

public enum Day13 {

    public static func part1(_ input: Input) throws -> Int {

        let time = try input.lines
            .compactMap(Int.init)
            .first
            .unwrapped()

        let buses = try input.lines
            .last
            .unwrapped()
            .components(separatedBy: ",")
            .compactMap(Int.init)

        return try buses.map { id -> (Int, Int) in
            let previousBus = time % id
            if previousBus == 0 { return (id, 0) }
            let nextBus = id - previousBus
            return (id, nextBus)
        }
        .min(by: { $0.1 < $1.1 })
        .map(*)
        .unwrapped()
    }

    public static func part2(_ input: Input) throws -> Int {
        0
    }
}
