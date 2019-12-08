
import SwiftUI

struct ContentView: View {

    @SwiftUI.State var showing = Showing.loader

    func load(code: [Int]) {
        showing = .computer(code)
    }

    var body: some View {
        Group {
            showing.loaderView(load)
            showing.computerView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

enum Showing {
    case loader
    case computer([Int])
}

extension Showing {

    func loaderView(_ handler: @escaping ([Int]) -> ()) -> Loader? {
        switch self {
        case .loader: return Loader(handler: handler)
        default: return nil
        }
    }

    var computerView: IntcodeComputerView? {
        guard case let .computer(code) = self else { return nil }
        return IntcodeComputerView(code: code)
    }
}
