
import Advent

// MARK: - Input

extension IntcodeComputer {

    init(input: Input) {

        let code = input
              .lines
              .map { $0.string }
              .flatMap { $0.components(separatedBy: ",") }
              .compactMap { Int($0) }

        self.init(code: code)
    }
}
