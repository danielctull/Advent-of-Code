
public struct IntcodeComputer {

    private var memory: [Int]
    public init(memory: [Int]) {
        self.memory = memory
    }

    mutating public func run() -> [Int] {

        var instructionPointer = 0
        while instructionPointer < memory.count {

            func perform(_ closure: (Int, Int) -> Int) {
                let position1 = memory[instructionPointer + 1]
                let position2 = memory[instructionPointer + 2]
                let position3 = memory[instructionPointer + 3]
                memory[position3] = closure(memory[position1], memory[position2])
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
