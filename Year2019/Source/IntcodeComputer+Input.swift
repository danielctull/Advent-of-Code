
import Advent

// MARK: - Input

extension IntcodeComputer {

    init(input: Input) {

        let code = input
              .lines
              .flatMap { $0.components(separatedBy: ",") }
              .compactMap { Int($0) }

        self.init(code: code)
    }
}
