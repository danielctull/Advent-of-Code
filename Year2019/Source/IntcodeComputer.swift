
struct IntcodeComputer {

    private var memory: [Int]
    private var instructionPointer = 0
    init(memory: [Int]) {
        self.memory = memory
    }

    mutating func run() -> [Int] {

        while instructionPointer < memory.count {

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

    struct Instruction {
        let value: Int
        let instructionPointer: Int
    }

    var instruction: Instruction {
        Instruction(value: memory[instructionPointer],
                    instructionPointer: instructionPointer)
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
        case 0: return .position(instructionPointer + offset)
        case 1: return .immediate(instructionPointer + offset)
        default: fatalError()
        }
    }
}

extension IntcodeComputer {

    enum Parameter {
        case immediate(Int)
        case position(Int)
    }

    subscript(parameter: Parameter) -> Int {
        get {
            switch parameter {
            case let .immediate(pointer): return memory[pointer]
            case let .position(pointer): return memory[memory[pointer]]
            }
        }
        set(newValue) {
            switch parameter {
            case let .immediate(pointer): memory[pointer] = newValue
            case let .position(pointer): memory[memory[pointer]] = newValue
            }
        }
    }
}
