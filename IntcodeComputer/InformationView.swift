
import Year2019
import SwiftUI

struct InformationView: View {

    let computer: IntcodeComputer

    var output: String {
        guard let output = computer.output.map(String.init) else { return "" }
        return "Output " + output
    }

    var body: some View {
        HStack {
            if computer.operationName != nil {
                Text(String(computer.operationName!))
                    .padding(4)
                    .background(Color.yellow)
                    .cornerRadius(4)
            }
            if computer.isWaiting {
                Text("Waiting")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(4)
            }
            if computer.isHalted {
                Text("Halted")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(4)
            }
            if computer.output != nil {
                Text("Output: \(String(computer.output!))")
                    .padding(4)
                    .background(Color.green)
                    .cornerRadius(4)
            }
        }
        .font(.custom("SF Mono", size: 14))
    }
}
