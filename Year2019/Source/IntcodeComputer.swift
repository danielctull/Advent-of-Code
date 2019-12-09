
public struct IntcodeComputer {

    private var state: State
    public init(code: [Int]) {
        self.state = State(code: code)
    }

    public mutating func input(_ input: Int) {
        state.inputs.append(input)
    }

    public mutating func run() throws {

        while !state.waiting, state.instruction != nil {
            try step()
        }
    }

    public mutating func step() throws {

        guard let instruction = state.instruction else { return }

        guard let operation = operations[instruction.code] else {
            throw UnknownInstruction(code: instruction.code)
        }

        operation.action(instruction, &state)
    }
}

// MARK: - Errors

struct UnknownInstruction: Error {
    let code: Int
}

// MARK: - State

private struct State {
    var waiting = false
    var inputs: [Int] = [] {
        didSet { waiting = false }
    }
    var output: [Int] = []
    var relativeBase = Pointer()
    var pointer = Pointer()
    var halted = false
    var code: [Int]

    mutating func nextInput() -> Int? {

        guard inputs.count > 0 else {
            waiting = true
            return nil
        }

        return inputs.removeFirst()
    }
}

extension IntcodeComputer {
    public var code: [Int] { state.code }
    public var instructionPointer: Int { state.pointer.value }
    public var isHalted: Bool { state.halted }
    public var isWaiting: Bool { state.waiting }
    public var output: [Int] { state.output }
    public var operationName: String? {
        guard let code = state.instruction?.code else { return nil }
        return operations[code]?.name
    }
}

// MARK: - Operation

fileprivate let operations: [Int: Operation] = [
     1: .calculation("Add", +),
     2: .calculation("Multiply", *),
     3: .input,
     4: .output,
     5: .jump("Jump If True") { $0 != 0 },
     6: .jump("Jump If False") { $0 == 0 },
     7: .calculation("Less Than") { $0 < $1 ? 1 : 0 },
     8: .calculation("Equals") { $0 == $1 ? 1 : 0 },
     9: .adjustRelativeBase,
    99: .halt
]

fileprivate struct Operation {
    let name: String
    let action: (Instruction, inout State) -> ()
}

extension Operation {

    static let halt = Operation(name: "Halt") { _, state in
        state.halted = true
        state.pointer = Pointer(state.code.count)
    }

    static func calculation(
        _ name: String,
        _ calculation: @escaping (Int, Int) -> Int
    ) -> Operation {

        Operation(name: name) { instruction, state in
            state[instruction + 3] = calculation(state[instruction + 1],
                                                  state[instruction + 2])
            state.pointer += 4
        }
    }

    static let input = Operation(name: "Input") { instruction, state in
        guard let input = state.nextInput() else { return }
        state[instruction + 1] = input
        state.pointer += 2
    }

    static let output = Operation(name: "Output") { instruction, state in
        state.output.append(state[instruction + 1])
        state.pointer += 2
    }

    static func jump(
        _ name: String,
        _ expression: @escaping (Int) -> Bool
    ) -> Operation {
        
        Operation(name: name) { instruction, state in
            if expression(state[instruction + 1]) {
                state.pointer = Pointer(state[instruction + 2])
            } else {
                state.pointer += 3
            }
        }
    }

    static let adjustRelativeBase = Operation(name: "Adjust Relative Base") {
        instruction, state in
        state.relativeBase += state[instruction + 1]
        state.pointer += 2
    }
}

// MARK: - Instruction

fileprivate struct Instruction {
    let value: Int
    let pointer: Pointer
}

extension State {

    fileprivate var instruction: Instruction? {
        guard pointer.value < code.count else { return nil }
        return Instruction(value: self[pointer], pointer: pointer)
    }
}

extension Instruction {

    var code: Int { value % 10000 % 1000 % 100 }
}

fileprivate func +(_ instruction: Instruction, offset: Int) -> Parameter {

    let parameterCode: Int
    switch offset {
    case 1: parameterCode = instruction.value % 10000 % 1000 / 100
    case 2: parameterCode = instruction.value % 10000 / 1000
    case 3: parameterCode = instruction.value / 10000
    default: fatalError()
    }

    switch parameterCode {
    case 0: return .position(instruction.pointer + offset)
    case 1: return .immediate(instruction.pointer + offset)
    case 2: return .relative(instruction.pointer + offset)
    default: fatalError()
    }
}

// MARK: - Parameter

fileprivate enum Parameter {
    case immediate(Pointer)
    case position(Pointer)
    case relative(Pointer)
}

extension State {

    fileprivate subscript(parameter: Parameter) -> Int {
        get {
            switch parameter {
            case let .immediate(pointer): return self[pointer]
            case let .position(pointer): return self[Pointer(self[pointer])]
            case let .relative(pointer): return self[relativeBase + self[pointer]]
            }
        }
        set(newValue) {
            switch parameter {
            case let .immediate(pointer): self[pointer] = newValue
            case let .position(pointer): self[Pointer(self[pointer])] = newValue
            case let .relative(pointer): self[relativeBase + self[pointer]] = newValue
            }
        }
    }
}

// MARK: - Pointer

fileprivate struct Pointer {
    let value: Int
    init() { value = 0 }
    init(_ value: Int) { self.value = value }
}

extension State {

    fileprivate subscript(pointer: Pointer) -> Int {
        get {
            guard pointer.value < code.count else { return 0 }
            return code[pointer.value]
        }
        set {
            if pointer.value >= code.count {
                code += Array(repeating: 0, count: pointer.value + 1 - code.count)

            }
            code[pointer.value] = newValue
        }
    }
}

fileprivate func +=(_ pointer: inout Pointer, _ offset: Int) {
    pointer = Pointer(pointer.value + offset)
}

fileprivate func +(_ pointer: Pointer, _ offset: Int) -> Pointer {
    Pointer(pointer.value + offset)
}
