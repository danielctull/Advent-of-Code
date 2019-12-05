
struct IntcodeComputer {

    private var memory: Memory
    private var instructionPointer = Pointer()
    init(memory: [Int]) {
        self.memory = Memory(value: memory)
    }

    mutating func run() -> [Int] {

        while !memory.isEnd(instructionPointer) {

            func perform(_ closure: (Int, Int) -> Int) {
                let parameter1 = instruction.parameter(at: 1)
                let parameter2 = instruction.parameter(at: 2)
                let parameter3 = instruction.parameter(at: 3)
                memory[parameter3] = closure(memory[parameter1], memory[parameter2])
                instructionPointer += 4
            }

            switch instruction.code {
            case 1: perform(+)
            case 2: perform(*)
            case 99: return memory.value
            default: fatalError()
            }
        }

        fatalError()
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

extension IntcodeComputer {

    fileprivate var instruction: Instruction {
        Instruction(value: memory[instructionPointer],
                    pointer: instructionPointer)
    }
}

extension Instruction {

    var code: Int { value % 10000 % 1000 % 100 }

    func parameter(at offset: Int) -> Parameter {

        let parameterCode: Int
        switch offset {
        case 1: parameterCode = (value - code) / 100
        case 2: parameterCode = (value - code) / 1000
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
