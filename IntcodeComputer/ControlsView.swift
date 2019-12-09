
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
    @State var speed = 0.8

    func step() { try? computer.step() }
    func run() {
        try? computer.step()
        if !computer.isHalted || !computer.isWaiting {
            DispatchQueue.main.asyncAfter(deadline: .now() + (1 - speed), execute: run)
        }
    }

    var body: some View {
        HStack {
            Button(action: step) { Text("Step") }
            Button(action: run) { Text("Run") }
            SpeedView(speed: $speed)
        }
    }
}


fileprivate struct SpeedView: View {

    @Binding var speed: Double

    var body: some View {
        VStack(spacing: 0) {
            Text("Speed")
            Slider(value: $speed,
                   in: 0...0.98,
                   minimumValueLabel: Text("🐢"),
                   maximumValueLabel: Text("🐇"))
                .frame(width: 200)
        }
    }
}

extension Slider where Label == EmptyView {

    public init<V>(value: Binding<V>,
                   in bounds: ClosedRange<V> = 0...1,
                   minimumValueLabel: ValueLabel,
                   maximumValueLabel: ValueLabel
    ) where
        V: BinaryFloatingPoint,
        V.Stride: BinaryFloatingPoint
    {
        self.init(value: value,
                  in: bounds,
                  minimumValueLabel: minimumValueLabel,
                  maximumValueLabel: maximumValueLabel,
                  label: { EmptyView() })
    }
}
