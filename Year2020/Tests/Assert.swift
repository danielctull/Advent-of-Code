
import Advent
import XCTest

extension Input {

    static func file(_ name: String) throws -> Input {
        try Bundle.module.input(named: name)
    }
}

func Assert<Input, Output: Equatable>(
    _ function: (Input) throws -> Output,
    _ input: Input,
    _ output: Output,
    file: StaticString = #file,
    line: UInt = #line
) rethrows {
    XCTAssertEqual(try function(input), output, file: file, line: line)
}
