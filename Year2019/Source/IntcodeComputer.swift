
public struct IntcodeComputer {

    let memory: Memory
    public init(code: [Int]) {
        self.memory = Memory(inputs: [], code: code)
    }

    public init(code: [Int], input: Int...) {
        self.memory = Memory(inputs: input, code: code)
    }

    @discardableResult
    public func run() throws -> Memory {

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

        var memory = self.memory

        while let instruction = memory.instruction {

            guard let operation = operations[instruction.code] else {
                struct UnknownInstruction: Error {
                    let code: Int
                }
                throw UnknownInstruction(code: instruction.code)
            }

            operation.action(instruction, &memory)

        }

        return memory
    }
}

// MARK: - Memory

public struct Memory {
    fileprivate var inputs: [Int]
    fileprivate var output: Int? = nil
    fileprivate var pointer = Pointer()
    public var value: Int { output ?? .min }
    public var code: [Int]
    
    fileprivate mutating func nextInput() -> Int { inputs.removeFirst() }
}

// MARK: - Operation

fileprivate struct Operation {
    let action: (Instruction, inout Memory) -> ()
}

extension Operation {

    static let halt = Operation { _, memory in
        memory.pointer = Pointer(memory.code.count)
    }

    static func calculation(
        _ calculation: @escaping (Int, Int) -> Int
    ) -> Operation {

        Operation { instruction, memory in
            memory[instruction + 3] = calculation(memory[instruction + 1],
                                                  memory[instruction + 2])
            memory.pointer += 4
        }
    }

    static let input = Operation { instruction, memory in
        memory[instruction + 1] = memory.nextInput()
        memory.pointer += 2
    }

    static let output = Operation { instruction, memory in
        memory.output = memory[instruction + 1]
        memory.pointer += 2
    }

    static func jump(_ expression: @escaping (Int) -> Bool) -> Operation {
        
        Operation { instruction, memory in
            if expression(memory[instruction + 1]) {
                memory.pointer = Pointer(memory[instruction + 2])
            } else {
                memory.pointer += 3
            }
        }
    }
}

// MARK: - Instruction

fileprivate struct Instruction {
    let value: Int
    let pointer: Pointer
}

extension Memory {

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

extension Memory {

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

extension Memory {

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
