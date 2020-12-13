
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
            let next = Bus(id).next(after: time)
            return (id, next)
        }
        .min(by: { $0.1 < $1.1 })
        .map(*)
        .unwrapped()
    }

    //--------------------------------------------------------------------------
    // For the following sequence:
    // 7, 13, x, x, 59, x, 31, 19
    //
    // 7, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105
    //
    // 13, 26, 39, 52, 65, 78, 91, 104
    // 14, 27, 40, 53, 66, 79, 92, 105
    //
    // 59, 118, 177, 236, 295, 354, 413, 472
    // 63, 122,
    //
    //                     77     168     259   > +91  => +7*13
    // bus:7  offset:0     11      24      37   > +13
    // bus:13 offset:1   5r12   12r12   19r12   > +7 r(13-1)
    //
    //                    350     763    1176   > +413 => +7*59
    // bus:7  offset:0     50     109     168   > +59
    // bus:59 offset:4   5r55   12r55   19r55   > +7 r(59-4)
    //
    //                     56    273     490    > +217 => +7*31
    // bus:7  offset:0      8     39      70    > +31
    // bus:31 offset:6   1r25   8r25   15r25    > +7 r(31-6)
    //--------------------------------------------------------------------------

    public static func part2(_ input: Input) throws -> Int {

        return try input.lines
            .last
            .unwrapped()
            .components(separatedBy: ",")
            .map(Int.init)
            .enumerated()
            .compactMap { offset, id -> (Offset, Bus)? in
                guard let id = id else { return nil }
                return (Offset(offset), Bus(id))
            }
            .reduce { t1, t2 -> (Offset, Bus) in
                let (offset1, bus1) = t1
                let (offset2, bus2) = t2

                let lowestCommon = try stride(from: offset1.rawValue, to: .max, by: bus1.id)
                    .first(where: { goal in
                        (goal + offset2.rawValue).isMultiple(of: bus2.id)
                    })
                    .unwrapped()

                return (Offset(lowestCommon), Bus(bus1.id * bus2.id))
            }
            .unwrapped().0.rawValue
    }
}

extension Day13 {

    fileprivate struct Bus: Equatable {
        let id: Int
        init(_ id: Int) { self.id = id }
    }

    fileprivate struct Offset: Equatable, ExpressibleByIntegerLiteral {
        let rawValue: Int
        init(_ value: Int) { rawValue = value }
        init(integerLiteral value: Int) { rawValue = value }
    }

    fileprivate struct Timestamp: Equatable, ExpressibleByIntegerLiteral {
        let rawValue: Int
        init(_ value: Int) { rawValue = value }
        init(integerLiteral value: Int) { rawValue = value }
    }
}

extension Day13.Bus {

    func next(after time: Int) -> Int {
        let previousBus = time % id
        if previousBus == 0 { return 0 }
        return id - previousBus
    }
}


extension Day13.Bus: CustomStringConvertible {
    var description: String { "Bus(id: \(id))" }
}

