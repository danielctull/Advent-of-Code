
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
            let next = Bus(id: id).next(after: time)
            return (id, next)
        }
        .min(by: { $0.1 < $1.1 })
        .map(*)
        .unwrapped()
    }

    public static func part2(_ input: Input) throws -> Int {

        let buses = try input.lines
            .last
            .unwrapped()
            .components(separatedBy: ",")
            .map(Int.init)

        let timeBuses = zip(0..., buses)
            .compactMap { time, bus -> (Int, Bus)? in
                guard let bus = bus else { return nil }
                return (time, Bus(id: bus))
            }

        // For the following sequence:
        // 7, 13, x, x, 59, x, 31, 19
        //
        //              77     168     259
        // id:7  p:0    11      24      37   > +13
        // id:13 p:1  5r12   12r12   19r12   > +7 r(13-1)
        //
        //             350     763    1176
        // id:7  p:0    50     109     168   > +59
        // id:59 p:4  5r55   12r55   19r55   > +7 r(59-4)
        //
        //              56    273     490
        // id:7  p:0     8     39      70   > +31
        // id:31 p:6  1r25   8r25   15r25   > +7 r(31-6)

        // Get the bus with the time expectation of zero – should always exist.
        let first = try timeBuses.first(where: { $0.0 == 0 }).unwrapped()

        print(first)
        print(timeBuses)

        let lowests = try timeBuses
            .dropFirst()
            .map { time, bus -> LazyMapSequence<(PartialRangeFrom<Int>), Int> in

                let lowestCommon = try (1...)
                    .lazy
                    .first(where: { goal in
                        let next = bus.next(after: goal * first.1.id)
                        return next == time
                    })
                    .unwrapped()

                return (0...).lazy.map { $0 * bus.id + lowestCommon }
            }

        for lowest in lowests {
            print("-------")
            var i = lowest.makeIterator()
            print(i.next()!) * 30
        }

//        let bus = try timeBuses
//            .reduce { previous, next in
//
//                let lowestCommon = try (1...)
//                    .lazy
//                    .first(where: { goal in
//                        let next = bus.next(after: goal * first.1.id)
//                        return next == time
//                    })
//                    .unwrapped()
//
//                return (1...).lazy.map { $0 * bus.id + lowestCommon }
//            }

        return 0
//        return try lowests
//            .reduce(lowestCommonMultiple)
//            .unwrapped()





//        let predicates = requiredTimes
//            .map { time, bus in
//                Predicate { bus.next(after: $0) == time }
//            }
//
//        let max = try requiredTimes
//            .max(by: { lhs, rhs in lhs.1.id < lhs.1.id })
//            .unwrapped()
//
//        // value * id - time
//        // time / id = value
//
//        return try (100000000000...)
//            .lazy
//            .map { $0 * max.1.id - max.0 } // Only search times for the largest bus
//            .first(where: predicates.satisfiedBy)
//            .unwrapped()
    }
}

extension Day13 {

    fileprivate struct Bus {
        let id: Int
    }

    fileprivate struct Position: RawRepresentable {
        let rawValue: Int
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
