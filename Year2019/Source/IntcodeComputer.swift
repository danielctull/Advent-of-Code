
public struct IntcodeComputer {

    public var state: State
    public init(code: [Int]) {
        self.state = State(code: code)
    }

    public mutating func loadInput(_ input: Int) {
        state.inputs.append(input)
    }

    public mutating func run() throws {

        while !state.waiting, state.instruction != nil {
            try step()
        }
    }

    public mutating func step() throws {

        let operations: [Int: Operation] = [
             1: .calculation(+),
             2: .calculation(*),
             3: .input,
             4: .output,
             5: .jump { $0 != 0 },
             6: .jump { $0 == 0 },
             7: .calculation { $0 < $1 ? 1 : 0 },
             8: .calculation { $0 == $1 ? 1 : 0 },
            99: .halt
        ]

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

public struct State {
    fileprivate var waiting = false
    fileprivate var inputs: [Int] = [] {
        didSet { waiting = false }
    }
    fileprivate var output: Int? = nil
    fileprivate var pointer = Pointer()
    public var halted = false
    public var value: Int { output ?? .min }
    public var code: [Int]

    fileprivate mutating func nextInput() -> Int? {

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
    public var output: Int? { state.output }
}

// MARK: - Operation

fileprivate struct Operation {
    let action: (Instruction, inout State) -> ()
}

extension Operation {

    static let halt = Operation { _, state in
        state.halted = true
        state.pointer = Pointer(state.code.count)
    }

    static func calculation(
        _ calculation: @escaping (Int, Int) -> Int
    ) -> Operation {

        Operation { instruction, state in
            state[instruction + 3] = calculation(state[instruction + 1],
                                                  state[instruction + 2])
            state.pointer += 4
        }
    }

    static let input = Operation { instruction, state in
        guard let input = state.nextInput() else { return }
        state[instruction + 1] = input
        state.pointer += 2
    }

    static let output = Operation { instruction, state in
        state.output = state[instruction + 1]
        state.pointer += 2
    }

    static func jump(_ expression: @escaping (Int) -> Bool) -> Operation {
        
        Operation { instruction, state in
            if expression(state[instruction + 1]) {
                state.pointer = Pointer(state[instruction + 2])
            } else {
                state.pointer += 3
            }
        }
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
    default: fatalError()
    }
}

// MARK: - Parameter

fileprivate enum Parameter {
    case immediate(Pointer)
    case position(Pointer)
}

extension State {

    fileprivate subscript(parameter: Parameter) -> Int {
        get {
            switch parameter {
            case let .immediate(pointer): return self[pointer]
            case let .position(pointer): return code[self[pointer]]
            }
        }
        set(newValue) {
            switch parameter {
            case let .immediate(pointer): self[pointer] = newValue
            case let .position(pointer): code[self[pointer]] = newValue
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
        get { code[pointer.value] }
        set { code[pointer.value] = newValue }
    }
}

fileprivate func +=(_ pointer: inout Pointer, _ offset: Int) {
    pointer = Pointer(pointer.value + offset)
}

fileprivate func +(_ pointer: Pointer, _ offset: Int) -> Pointer {
    Pointer(pointer.value + offset)
}
