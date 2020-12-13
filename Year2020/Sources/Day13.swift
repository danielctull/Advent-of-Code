
import Advent
import Foundation

public enum Day13: Day {

    public static let title = "Shuttle Search"

    public static func part1(_ input: Input) throws -> Int {

        let goal = try input.lines
            .compactMap(Int.init)
            .first
            .unwrapped()

        return try input.lines
            .last
            .unwrapped()
            .components(separatedBy: ",")
            .compactMap(Int.init)
            .map { bus -> (Int, Int) in
                let remainder = goal % bus
                if remainder == 0 { return (bus, 0) }
                let time = bus - remainder
                return (bus, time)
            }
            .min(by: { $0.1 < $1.1 })
            .map(*)
            .unwrapped()
    }

    //--------------------------------------------------------------------------
    // For the following sequence:
    // 7, 13, x, x, 59, x, 31, 19
    //
    // bus with offset 0
    // 7, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105
    //
    // bus with offset 1
    // 13, 26, 39, 52, 65, 78, 91, 104
    // 14, 27, 40, 53, 66, 79, 92, 105
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
    //
    //                       350    5719    11088   > +7*13*59
    // bus:7*13 offset:77   3r77   62r77   121r77   > +59 r(offset)
    // bus:59   offset:4    5r55   96r55   187r55   > +91 r(bus-offset)
    //--------------------------------------------------------------------------

    public static func part2(_ input: Input) throws -> Int {

        try input.lines
            .last
            .unwrapped()
            .components(separatedBy: ",")
            .map(Int.init)
            .enumerated()
            .compactMap { offset, bus -> (Int, Int)? in
                guard let bus = bus else { return nil }
                return (offset, bus)
            }
            .reduce { t1, t2 -> (Int, Int) in
                let (offset1, bus1) = t1
                let (offset2, bus2) = t2

                let lowestCommon = try stride(from: offset1, to: .max, by: bus1)
                    .first(where: { ($0 + offset2).isMultiple(of: bus2) })
                    .unwrapped()

                return (lowestCommon, bus1 * bus2)
            }
            .unwrapped().0
    }
}
