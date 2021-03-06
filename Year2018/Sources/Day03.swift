
import Advent
import Algorithms
import Foundation

public struct Day03 {

    public init() {}

    public func part1(input: Input) -> Int {

        return input
            .lines
            .compactMap(Claim.init)
            .flatMap { $0.locations }
            .countByElement
            .values
            .filter { $0 > 1 }
            .count
    }

    public func part2(input: Input) -> String {

        let claims = input
            .lines
            .compactMap(Claim.init)

        let soloClaimLocations = claims
            .flatMap { $0.locations }
            .countByElement
            .filter { $0.value == 1 }
            .keys

        let solo = Set(soloClaimLocations)

        return claims
            .filter { Set($0.locations).isSubset(of: solo) }
            .first?
            .name ?? ""
    }
}

private struct Claim {
    let name: String
    let position: Position
    let size: Size
}

extension Claim {

    init?(_ string: String) {

        let components = string
            .replacingOccurrences(of: " ", with: "")
            .components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted)
            .filter { !$0.isEmpty }

        guard components.count == 5 else { return nil }

        name = components[0]
        position = Position(x: Int(components[1])!, y: Int(components[2])!)
        size = Size(width: Int(components[3])!, height: Int(components[4])!)
    }
}

extension Claim {

    var locations: [Position] {

        let xs = position.x ..< position.x + size.width
        let ys = position.y ..< position.y + size.height

        return zip(xs.cycled(), ys.repeatingElements(xs.count))
            .map(Position.init)
    }
}

private struct Position: Hashable {
    let x: Int
    let y: Int
}

private struct Size {
    let width: Int
    let height: Int
}
