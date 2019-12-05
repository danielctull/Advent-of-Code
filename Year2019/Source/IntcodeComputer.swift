
public struct IntcodeComputer {

    private var memory: [Int]
    public init(memory: [Int]) {
        self.memory = memory
    }

    mutating public func run() -> [Int] {

        var instructionPointer = 0
        while instructionPointer < memory.count {

            func perform(_ closure: (Int, Int) -> Int) {
                let parameter1 = Parameter.position(instructionPointer + 1)
                let parameter2 = Parameter.position(instructionPointer + 2)
                let parameter3 = Parameter.position(instructionPointer + 3)
                self[parameter3] = closure(self[parameter1], self[parameter2])
                instructionPointer += 4
            }

            switch memory[instructionPointer] {
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
