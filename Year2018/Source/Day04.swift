
import Advent
import Foundation

public struct Day04 {

    public init() {}

    public func part1(input: Input) -> Int {

        let minutesAsleep = self.minutesAsleep(input: input)

        let maxGuard = minutesAsleep
            .map { $0.guard }
            .countByElement
            .max { $0.value < $1.value }
            .map { $0.key }

        guard let maximumGuard = maxGuard else { return 0 }

        let maxMinute = minutesAsleep
            .filter { $0.guard == maximumGuard }
            .countByElement
            .max { $0.value < $1.value }
            .map { $0.key.minute.value }

        guard let maximumMinute = maxMinute else { return 0 }

        return maximumGuard * maximumMinute
    }

    public func part2(input: Input) -> Int {

        let minutesAsleep = self.minutesAsleep(input: input)

        let maxMinuteAsleep = minutesAsleep
            .group(by: { $0.guard })
            .mapValues { minutesGuardAsleep in

                return minutesGuardAsleep
                    .countByElement
                    .max { $0.value < $1.value }!
            }
            .values
            .max { $0.value < $1.value }!
            .key

        return maxMinuteAsleep.guard * maxMinuteAsleep.minute.value
    }

    func minutesAsleep(input: Input) -> [MinuteAsleep] {

        var `guard`: Guard?
        var asleep: Minute?

        return input
            .lines
            .map { $0.string }
            .sorted()
            .map(Event.init)
            .flatMap { event -> [MinuteAsleep] in

                guard let event = event else { return [] }

                switch event.kind {

                case .beginsShift(let guardNumber):
                    asleep = nil
                    `guard` = guardNumber
                    return []

                case .fallsAsleep:
                    asleep = event.minute
                    return []

                case .wakesUp:

                    guard
                        let `guard` = `guard`,
                        let asleep = asleep
                    else {
                        return []
                    }

                    let minutesAsleep = asleep.value..<event.minute.value

                    return minutesAsleep.map {
                        MinuteAsleep(guard: `guard`, minute: Minute($0))
                    }
                }
            }
    }
}

struct Event {
    let minute: Minute
    let kind: Kind
}

struct MinuteAsleep: Hashable {
    let `guard`: Guard
    let minute: Minute

}

typealias Guard = Int

extension Event {

    enum Kind {
        case wakesUp
        case fallsAsleep
        case beginsShift(Guard)
    }

    init?(_ string: String) {

        let components = string.components(separatedBy: "] ")
        guard
            let minute = components.first.flatMap(Minute.init),
            let kind = components.last.flatMap(Event.Kind.init)
        else {
            return nil
        }

        self.minute = minute
        self.kind = kind
    }
}

struct Minute: Hashable {

    let value: Int

    init(_ value: Int) {
        self.value = value
    }

    init?(_ string: String) {

        guard let minute = string.components(separatedBy: ":").last.flatMap(Int.init) else {
            return nil
        }

        value = minute
    }
}

extension Event.Kind {

    init?(_ string: String) {

        switch string {
        case "falls asleep": self = .fallsAsleep
        case "wakes up": self = .wakesUp
        default:
            let numbers = CharacterSet(charactersIn: "0123456789")
            guard let guardNumber = string
                .components(separatedBy: numbers.inverted)
                .filter({ !$0.isEmpty })
                .first
                .flatMap(Guard.init) else { return nil }

            self = .beginsShift(guardNumber)
        }
    }
}
