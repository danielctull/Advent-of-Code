
import Advent
import Foundation

extension Input {

    init(named name: String, extension: String = "txt") throws {

        class BundleFinder {}
        let bundle = Bundle(for: BundleFinder.self)

        struct Error: Swift.Error {}
        guard let url = bundle.url(forResource: name, withExtension: `extension`) else { throw Error() }

        try self.init(url: url)
    }
}
