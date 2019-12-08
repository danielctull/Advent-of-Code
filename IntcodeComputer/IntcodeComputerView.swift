
import Year2019
import SwiftUI

struct IntcodeComputerView: View {

    @ObservedObject fileprivate var container: Container

    init(code: [Int]) {
        container = Container(code: code)
    }

    var body: some View {
        VStack {
            RegistersView(computer: container.computer)
            Spacer()
            InformationView(computer: container.computer)
            ControlsView(computer: $container.computer)
        }
    }
}

fileprivate final class Container: ObservableObject {

    @Published var computer: IntcodeComputer
    init(code: [Int]) {
        computer = IntcodeComputer(code: code)
    }
}
