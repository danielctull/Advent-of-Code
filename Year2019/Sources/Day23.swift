
import Advent
import Foundation

public struct Day23 {

    public init() {}

    public func part1(input: Input) throws -> Int {

        let computers = (0...49).map { _ in IntcodeComputer(input: input) }
        var controller = try NetworkInerfaceController(computers: computers)
        while controller.packets[255] == nil {
            try controller.run()
        }

        return controller.nextPacket(for: 255)!.y
    }

    public func part2(input: Input) throws -> Int {

        let computers = (0...49).map { _ in IntcodeComputer(input: input) }
        let controller = try NetworkInerfaceController(computers: computers)
        var nat = NotAlwaysTransmitting(controller: controller)

        while nat.sentYValueTwice == nil {
            try nat.run()
        }

        return nat.sentYValueTwice!
    }
}

fileprivate struct NotAlwaysTransmitting {

    var controller: NetworkInerfaceController
    var sent: [Packet] = []

    mutating func run() throws {
        try controller.run()

        let hasPackets = controller.packets.contains {
            (key: Int, value: [Packet]) -> Bool in
            key != 255 && value.count > 0
        }

        guard !hasPackets else { return }
        guard let packet = controller.packets[255]?.last else { return }
        sent.append(packet)
        controller.packets[0] = [packet]
    }
}

extension NotAlwaysTransmitting {

    var sentYValueTwice: Int? {
        sent.group(by: { $0.y })
            .first(where: { $0.value.count == 2 })?
            .key
    }
}

fileprivate struct NetworkInerfaceController {

    init(computers: [IntcodeComputer]) throws {
        network = [:]
        for (index, var computer) in computers.enumerated() {
            computer.input(index)
            try computer.run()
            network[index] = computer
        }
    }

    var packets: [Int: [Packet]] = [:]
    var network: [Int: IntcodeComputer]

    mutating func nextPacket(for index: Int) -> Packet? {
        var p = packets[index, default: []]
        guard !p.isEmpty else { return nil }
        defer { packets[index] = p }
        return p.removeFirst()
    }

    mutating func run() throws {
        for (index, var computer) in network.sorted(by: { $0.key < $1.key }) {

            defer { network[index] = computer }

            if let packet = nextPacket(for: index) {
                computer.input(packet.x)
                computer.input(packet.y)
            } else {
                computer.input(-1)
            }

            try computer.run()

            for output in computer.nextOutput().split(length: 3).map(Array.init) {
                let packet = Packet(x: output[1], y: output[2])
                packets[output[0], default: []].append(packet)
            }
        }
    }
}

fileprivate struct Packet {
    let x: Int
    let y: Int
}

extension Packet: CustomDebugStringConvertible {
    var debugDescription: String { "(x: \(x), y: \(y))" }
}
