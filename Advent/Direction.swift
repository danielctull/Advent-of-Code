
public enum Direction: Equatable, Hashable, CaseIterable {
    case up
    case down
    case left
    case right
}

public enum Turn {
    case left
    case right
}

extension Direction {

    public var opposite: Direction {
        switch self {
        case .down: return .up
        case .up: return .down
        case .left: return .right
        case .right: return .left
        }
    }

    public var otherDirections: [Direction] {
        var all = Direction.allCases
        all.removeAll(where: { $0 == self })
        return all
    }

    public func perform(_ turn: Turn) -> Direction {
        switch (self, turn) {
        case (.up, .left): return .left
        case (.right, .left): return .up
        case (.down, .left): return .right
        case (.left, .left): return .down

        case (.up, .right): return .right
        case (.right, .right): return .down
        case (.down, .right): return .left
        case (.left, .right): return .up
        }
    }
}

