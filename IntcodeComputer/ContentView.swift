
import SwiftUI

struct ContentView: View {

    @State private var showing = Showing.loader

    private func load(code: [Int]) {
        showing = .computer(code)
    }

    private func reset() {
        showing = .loader
    }

    var body: some View {
        VStack {
            showing.resetView(reset)
            Group {
                showing.loaderView(load)
                showing.computerView
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

fileprivate enum Showing {
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

    func resetView(_ reset: @escaping () -> ()) -> ResetView? {
        switch self {
        case .computer: return ResetView(reset: reset)
        default: return nil
        }
    }

    var computerView: IntcodeComputerView? {
        guard case let .computer(code) = self else { return nil }
        return IntcodeComputerView(code: code)
    }
}

fileprivate struct ResetView: View {

    let reset: () -> ()

    var body: some View {
        VStack {
            HStack {
                Button(action: reset) { Text("Reset") }
                Spacer()
            }
        }
    }
}
