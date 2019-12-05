
struct IntcodeComputer {

    private var memory: [Int]
    private var instructionPointer = Pointer()
    init(memory: [Int]) {
        self.memory = memory
    }

    mutating func run() -> [Int] {

        while instruction.pointer.value < memory.count {

            func perform(_ closure: (Int, Int) -> Int) {
                let parameter1 = instruction.parameter(at: 1)
                let parameter2 = instruction.parameter(at: 2)
                let parameter3 = instruction.parameter(at: 3)
                self[parameter3] = closure(self[parameter1], self[parameter2])
                instructionPointer += 4
            }

            switch instruction.code {
            case 1: perform(+)
            case 2: perform(*)
            case 99: return memory
            default: fatalError()
            }
        }

        fatalError()
    }
}

extension IntcodeComputer {

    fileprivate struct Instruction {
        let value: Int
        let pointer: IntcodeComputer.Pointer
    }

    fileprivate var instruction: Instruction {
        Instruction(value: self[instructionPointer],
                    pointer: instructionPointer)
    }
}

extension IntcodeComputer.Instruction {

    var code: Int { value % 10000 % 1000 % 100 }

    func parameter(at offset: Int) -> IntcodeComputer.Parameter {

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

extension IntcodeComputer {

    fileprivate enum Parameter {
        case immediate(Pointer)
        case position(Pointer)
    }

    fileprivate subscript(parameter: Parameter) -> Int {
        get {
            switch parameter {
            case let .immediate(pointer): return self[pointer]
            case let .position(pointer): return memory[self[pointer]]
            }
        }
        set(newValue) {
            switch parameter {
            case let .immediate(pointer): self[pointer] = newValue
            case let .position(pointer): memory[self[pointer]] = newValue
            }
        }
    }
}

extension IntcodeComputer {

    fileprivate struct Pointer {
        let value: Int
        init() { value = 0 }
        init(_ value: Int) { self.value = value }
    }

    fileprivate subscript(pointer: Pointer) -> Int {
        get { memory[pointer.value] }
        set { memory[pointer.value] = newValue }
    }
}

fileprivate func +(_ pointer: IntcodeComputer.Pointer, _ offset: Int) -> IntcodeComputer.Pointer {
    IntcodeComputer.Pointer(pointer.value + offset)
}

fileprivate func +=(_ pointer: inout IntcodeComputer.Pointer, _ offset: Int) {
    pointer = pointer + offset
}
