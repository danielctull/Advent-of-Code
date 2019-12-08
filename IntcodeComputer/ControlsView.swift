
import Year2019
import SwiftUI

struct ControlsView: View {

    @Binding var computer: IntcodeComputer

    var body: some View {
        Group {
            if computer.isWaiting {
                InputView(computer: $computer)
            } else {
                ButtonsView(computer: $computer)
            }
        }
    }
}

fileprivate struct InputView: View {

    @Binding var computer: IntcodeComputer
    @State var input = ""

    func loadInput() {
        guard let integer = Int(input) else { return }
        computer.loadInput(integer)
    }

    var body: some View {
        HStack {
            TextField("Input", text: $input)
                .frame(width: 150)
            
            Button(action: loadInput) { Text("Load Input") }
        }
    }
}

fileprivate struct ButtonsView: View {

    @Binding var computer: IntcodeComputer

    func step() { try? computer.step() }
    func run() { try? computer.run() }

    var body: some View {
        HStack {
            Button(action: step) { Text("Step") }
            Button(action: run) { Text("Run") }
        }
    }
}
