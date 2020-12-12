
public protocol Day {
    static var title: String { get }
    static func part1(_ input: Input) throws -> Int
    static func part2(_ input: Input) throws -> Int
}
