
import Advent
import Foundation

public struct Day09 {

    public init() {}

    public func part1(input: Input) -> Int {

        let components = input
            .lines
            .first!
            .string
            .components(separatedBy: " ")

        let playerCount = Int(components[0])!
        let marbleCount = Int(components[6])!

        let players = (0..<playerCount).repeating
        let marbles = (1...marbleCount)

        var scores: [Int: Int] = [:]
        let playedMarbles = CircularLinkedList(0)
        var current = playedMarbles.startIndex

        for (marble, player) in zip(marbles, players) {

            guard marble % 23 == 0 else {
                current = playedMarbles.index(after: current)
                playedMarbles.insert(marble, after: current)
                current = playedMarbles.index(after: current)
                continue
            }

            var remove = current
            playedMarbles.formIndex(&remove, offsetBy: -7)
            current = playedMarbles.index(after: remove)

            scores[player, default: 0] += marble
            scores[player, default: 0] += playedMarbles[remove]

            playedMarbles.remove(at: remove)
        }

        return scores.values.max()!
    }

    public func part2(input: Input) -> Int {
        return 0
    }
}

struct CircularLinkedList<Element> {

    typealias Index = Node

    class Node {

        let element: Element
        weak var next: Node?
        var previous: Node?

        init(_ element: Element) {
            self.element = element
        }
    }

    private var first: Node
    private var last: Node

    init(_ element: Element) {
        first = Node(element)
        last = first
        first.next = first
        first.previous = first
    }
}

extension CircularLinkedList: CustomStringConvertible {

    var description: String {

        var elements = [first.element]
        var current = first.next!

        while current !== first {
            elements.append(current.element)
            current = current.next!
        }

        return "[" + elements.map { String(describing: $0) }.joined(separator: ", ") + "]"
    }
}

extension CircularLinkedList {

    subscript(index: Index) -> Element {
        return index.element
    }

    var startIndex: Index {
        return first
    }

    func insert(_ element: Element, after previous: Index) {

        let node = Node(element)
        let next = previous.next

        previous.next = node
        node.previous = previous

        node.next = next
        next?.previous = node
    }

    func remove(at index: Index) {

        let previous = index.previous
        let next = index.next

        previous?.next = next
        next?.previous = previous
    }

    func index(after index: Index) -> Index {
        return index.next!
    }

    func formIndex(_ index: inout Index, offsetBy distance: Int) {

        let forwards = distance > 0

        for _ in 0..<abs(distance) {
            index = forwards ? index.next! : index.previous!
        }
    }
}
