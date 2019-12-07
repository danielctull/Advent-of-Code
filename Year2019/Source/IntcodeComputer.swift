
public struct IntcodeComputer {

    let state: State
    public init(code: [Int]) {
        self.state = State(code: code)
    }

    @discardableResult
    public func run() throws -> State { try run(inputs: []) }

    @discardableResult
    public func run(_ input: Int...) throws -> State { try run(inputs: input) }

    private func run(inputs: [Int]) throws -> State {

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

        var state = self.state
        state.inputs += inputs

        while let instruction = state.instruction {

            guard let operation = operations[instruction.code] else {
                struct UnknownInstruction: Error {
                    let code: Int
                }
                throw UnknownInstruction(code: instruction.code)
            }

            operation.action(instruction, &state)

        }

        return state
    }
}

// MARK: - State

public struct State {
    fileprivate var inputs: [Int] = []
    fileprivate var output: Int? = nil
    fileprivate var pointer = Pointer()
    public var value: Int { output ?? .min }
    public var code: [Int]
    
    fileprivate mutating func nextInput() -> Int { inputs.removeFirst() }
}

// MARK: - Operation

fileprivate struct Operation {
    let action: (Instruction, inout State) -> ()
}

extension Operation {

    static let halt = Operation { _, state in
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
        state[instruction + 1] = state.nextInput()
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
