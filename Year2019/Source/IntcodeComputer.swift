
struct IntcodeComputer {

    private var memory: Memory
    var value: Int
    init(memory: [Int], input: Int = 0) {
        self.memory = Memory(value: memory)
        self.value = input
    }

    @discardableResult
    mutating func run() -> [Int] {

        let operations: [Int: Operation] = [
            1: .calculation(+),
            2: .calculation(*),
            3: .input,
            4: .output,
            5: .jump { $0 != 0 },
            6: .jump { $0 == 0 },
            7: .calculation { $0 < $1 ? 1 : 0 },
            8: .calculation { $0 == $1 ? 1 : 0 },
        ]

        var instruction = memory.instruction(at: Pointer())

        while !memory.isEnd(instruction.pointer) {

            if instruction.code == 99 { break }

            guard let operation = operations[instruction.code] else {
                fatalError("Unknown instruction code: \(instruction.code)")
            }

            operation.action(&memory, &instruction, &value)
        }

        return memory.value
    }
}

fileprivate struct Operation {
    let action: (inout Memory, inout Instruction, inout Int) -> ()
}

extension Operation {

    static func calculation(_ calculation: @escaping (Int, Int) -> Int) -> Operation {

        Operation { memory, instruction, _ in
            let parameter1 = instruction.parameter(at: 1)
            let parameter2 = instruction.parameter(at: 2)
            let parameter3 = instruction.parameter(at: 3)
            memory[parameter3] = calculation(memory[parameter1], memory[parameter2])
            instruction = memory.instruction(at: instruction.pointer + 4)
        }
    }

    static var input: Operation {
        Operation { memory, instruction, input in
            let parameter = instruction.parameter(at: 1)
            memory[parameter] = input
            instruction = memory.instruction(at: instruction.pointer + 2)
        }
    }

    static var output: Operation {
        Operation { memory, instruction, value in
            let parameter = instruction.parameter(at: 1)
            value = memory[parameter]
            instruction = memory.instruction(at: instruction.pointer + 2)
        }
    }

    static func jump(_ expression: @escaping (Int) -> Bool) -> Operation {
        Operation { memory, instruction, _ in
            let parameter1 = instruction.parameter(at: 1)
            if expression(memory[parameter1]) {
                let parameter2 = instruction.parameter(at: 2)
                let pointer = Pointer(memory[parameter2])
                instruction = memory.instruction(at: pointer)
            } else {
                instruction = memory.instruction(at: instruction.pointer + 3)
            }
        }
    }
}

fileprivate struct Memory {
    var value: [Int]
}

extension Memory {

    func isEnd(_ pointer: Pointer) -> Bool {
        pointer.value >= value.count
    }
}

fileprivate struct Instruction {
    let value: Int
    let pointer: Pointer
}

extension Memory {

    fileprivate func instruction(at pointer: Pointer) -> Instruction {
        Instruction(value: self[pointer], pointer: pointer)
    }
}

extension Instruction {

    var code: Int { value % 10000 % 1000 % 100 }

    func parameter(at offset: Int) -> Parameter {

        let parameterCode: Int
        switch offset {
        case 1: parameterCode = (value - code) % 10000 % 1000 / 100
        case 2: parameterCode = (value - code) % 10000 / 1000
        case 3: parameterCode = (value - code) / 10000
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
            case let .position(pointer): return value[self[pointer]]
            }
        }
        set(newValue) {
            switch parameter {
            case let .immediate(pointer): self[pointer] = newValue
            case let .position(pointer): value[self[pointer]] = newValue
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
        get { value[pointer.value] }
        set { value[pointer.value] = newValue }
    }
}

fileprivate func +(_ pointer: Pointer, _ offset: Int) -> Pointer {
    Pointer(pointer.value + offset)
}

fileprivate func +=(_ pointer: inout Pointer, _ offset: Int) {
    pointer = pointer + offset
}
