
import Advent
import Foundation

extension Input {

    init(named name: String, extension: String = "txt") throws {

#if os(Linux)
        let bundle = Bundle.module
#else
        class BundleFinder {}
        let bundle = Bundle(for: BundleFinder.self)
#endif

        self = try bundle.input(named: name, extension: `extension`)
    }
}
