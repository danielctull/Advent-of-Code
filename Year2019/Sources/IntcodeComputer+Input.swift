
import Advent

// MARK: - Input

extension IntcodeComputer {

    public init(input: Input) {

        let code = input
              .lines
              .flatMap { $0.components(separatedBy: ",") }
              .compactMap(Int.init)

        self.init(code: code)
    }
}
