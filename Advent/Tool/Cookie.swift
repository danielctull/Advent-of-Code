
import ArgumentParser
import Foundation
import KeychainItem

struct Cookie: ParsableCommand {

    @Argument(help: "The session cookie.")
    var cookie: SessionCookie

    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "cookie",
            abstract: "Set your user session cookie.")
    }

    func run() {
#if canImport(Security)
        Keychain(.sessionCookie).wrappedValue = cookie
#else
        print("Cookie storage not currently supported on this platform.")
#endif
    }
}

// MARK: - Keychain Item

struct SessionCookie: Codable {
    let value: String
}

extension SessionCookie: ExpressibleByArgument {

    init(argument: String) {
        self.init(value: argument)
    }
}

extension KeychainItem where Value == SessionCookie {
    static let sessionCookie = Self(account: "uk.co.danieltull.aoc.session")
}
