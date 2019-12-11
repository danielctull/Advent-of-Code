
public enum Direction: Equatable, Hashable {
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
