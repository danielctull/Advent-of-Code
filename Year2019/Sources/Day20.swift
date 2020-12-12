
import Advent
import Foundation

public struct Day20 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let grid = try Grid<Position, Day20.Tile>(input: input)

        let start = grid
            .portals("A", "A")
            .compactMap(grid.vector(leaving:))
            .first!.0

        let end = grid
            .portals("Z", "Z")
            .compactMap(grid.vector(leaving:))
            .first!.0

        return grid.shortestDistance(
            from: start,
            to: end,
            move: { position, direction in

                let position = position + direction

                guard
                    let entrance = grid.portal(at: position),
                    let exit = grid.exit(of: entrance),
                    let output = grid.vector(leaving: exit)
                else {
                    return (position, direction)
                }

                return output
            },
            tile: { grid[$0] },
            isPath: { $0 == .passage })!
    }

    public func part2(input: Input) throws -> Int {

        let grid = try Grid<Position, Day20.Tile>(input: input)

        let start = grid
            .portals("A", "A")
            .compactMap(grid.vector(leaving:))
            .first!.0

        let end = grid
            .portals("Z", "Z")
            .compactMap(grid.vector(leaving:))
            .first!.0

        struct Node: Hashable {
            var level = 0
            var position = Position.origin
        }

        return grid.shortestDistance(
            from: Node(position: start),
            to: Node(position: end),
            move: { node, direction in

                var node = node
                node.position += direction
                let isOuter = grid.isOuter(node.position)

                guard
                    node.level != 0 || !isOuter,
                    let entrance = grid.portal(at: node.position),
                    let exit = grid.exit(of: entrance),
                    let output = grid.vector(leaving: exit)
                else {
                    return (node, direction)
                }

                node.position = output.0
                node.level += isOuter ? -1 : 1
                return (node, output.1)
            },
            tile: { grid[$0.position] },
            isPath: { $0 == .passage })!
    }
}

extension Grid where Location == Position, Tile == Day20.Tile {
    
    fileprivate func isOuter(_ position: Position) -> Bool {
        return position.x < 2
            || position.y < 2
            || position.x > maximum.x - 2
            || position.y > maximum.y - 2
    }

    fileprivate func exit(of portal: Portal) -> Portal? {
        portals(portal.character1, portal.character2)
            .first(where: { $0.position1 != portal.position1 })
    }

    fileprivate func vector(leaving portal: Portal) -> (Position, Vector<Int>)? {
        portal.exits.first(where: { self[$0.0] == .passage })
    }

    fileprivate func portals(_ character1: Character, _ character2: Character) -> Set<Portal> {

        let portals = positions(of: .portal(character1))
            .compactMap(portal(at:))
            .filter { $0.character1 == character1 && $0.character2 == character2 }

        return Set(portals)
    }

    fileprivate func portal(at position1: Position) -> Portal? {

        guard case let .portal(character1) = self[position1] else { return nil }

        return Vector<Int>
            .orthogonal
            .compactMap { direction -> Portal? in

                let position2 = position1 + direction
                guard case let .portal(character2) = self[position2] else { return nil }

                switch direction {
                case .up, .right:
                    return Portal(position1: position1,
                                  character1: character1,
                                  position2: position2,
                                  character2: character2)
                case .down, .left:
                    return Portal(position1: position2,
                                  character1: character2,
                                  position2: position1,
                                  character2: character1)
                default:
                    fatalError()
                }
            }
            .first
    }
}

fileprivate struct Portal: Hashable, Equatable {
    let position1: Position
    let character1: Character
    let position2: Position
    let character2: Character
}

extension Portal: CustomStringConvertible {

    var description: String {
        "Portal(\(character1)\(character2) \(position1.x),\(position1.y) \(position2.x),\(position2.y))"
    }
}

extension Portal {
    var exits: [(Position, Vector<Int>)] {
        let direction1 = Vector<Int>(from: position1, to: position2)
        let direction2 = Vector<Int>(from: position2, to: position1)
        return [
            (position2 + direction1, direction1),
            (position1 + direction2, direction2)
        ]
    }
}

// MARK: - Tile

extension Day20 {

    enum Tile {
        case wall
        case passage
        case space
        case portal(Character)
    }
}

extension Day20.Tile: Equatable {}

extension Day20.Tile: RawRepresentable {

    init?(rawValue: Character) {
        switch rawValue {
        case "#": self = .wall
        case ".": self = .passage
        case " ": self = .space
        case "A"..."Z": self = .portal(rawValue)
        default: return nil
        }
    }

    var rawValue: Character {
        switch self {
        case .wall: return "#"
        case .passage: return "."
        case .space: return " "
        case .portal(let value): return value
        }
    }
}

extension Day20.Tile: CustomStringConvertible {

    var description: String { String(rawValue) }
}
