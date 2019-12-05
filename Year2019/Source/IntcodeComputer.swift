
public struct IntcodeComputer {

    let memory: Memory
    public init(code: [Int], input: Int = 0) {
        self.memory = Memory(value: input, code: code)
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
        var pointer = Pointer()

        while let instruction = memory.instruction(at: pointer) {

            guard let operation = operations[instruction.code] else {
                throw UnknownInstruction(code: instruction.code)
            }

            pointer = operation.action(instruction, &memory)
        }

        return memory
    }
}

struct UnknownInstruction: Error {
    let code: Int
}

fileprivate struct Operation {
    let action: (Instruction, inout Memory) -> (Pointer)
}

extension Operation {

    static let halt = Operation { _, memory in
        Pointer(memory.code.count)
    }

    static func calculation(_ calculation: @escaping (Int, Int) -> Int) -> Operation {

        Operation { instruction, memory in
            let parameter1 = instruction.parameter(at: 1)
            let parameter2 = instruction.parameter(at: 2)
            let parameter3 = instruction.parameter(at: 3)
            memory[parameter3] = calculation(memory[parameter1], memory[parameter2])
            return instruction.pointer + 4
        }
    }

    static let input = Operation { instruction, memory in
        let parameter = instruction.parameter(at: 1)
        memory[parameter] = memory.value
        return instruction.pointer + 2
    }

    static let output = Operation { instruction, memory in
        let parameter = instruction.parameter(at: 1)
        memory.value = memory[parameter]
        return instruction.pointer + 2
    }

    static func jump(_ expression: @escaping (Int) -> Bool) -> Operation {
        
        Operation { instruction, memory in
            let parameter1 = instruction.parameter(at: 1)
            if expression(memory[parameter1]) {
                let parameter2 = instruction.parameter(at: 2)
                return Pointer(memory[parameter2])
            } else {
                return instruction.pointer + 3
            }
        }
    }
}

public struct Memory {
    public var value: Int
    public var code: [Int]
}

fileprivate struct Instruction {
    let value: Int
    let pointer: Pointer
}

extension Memory {

    fileprivate func instruction(at pointer: Pointer) -> Instruction? {
        guard pointer.value < code.count else { return nil }
        return Instruction(value: self[pointer], pointer: pointer)
    }
}

extension Instruction {

    var code: Int { value % 10000 % 1000 % 100 }

    func parameter(at offset: Int) -> Parameter {

        let parameterCode: Int
        switch offset {
        case 1: parameterCode = value % 10000 % 1000 / 100
        case 2: parameterCode = value % 10000 / 1000
        case 3: parameterCode = value / 10000
        default: fatalError()
        }

        switch parameterCode {
        case 0: return .position(pointer + offset)
        case 1: return .immediate(pointer + offset)
        default: fatalError()
        }
    }
}

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

fileprivate func +(_ pointer: Pointer, _ offset: Int) -> Pointer {
    Pointer(pointer.value + offset)
}
