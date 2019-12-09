
import Year2019
import SwiftUI

struct InformationView: View {

    let computer: IntcodeComputer

    var body: some View {
        VStack {
            OutputView(output: computer.output)
                .padding(.bottom)
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
            }
        }
        .font(.custom("SF Mono", size: 14))
    }
}

fileprivate struct OutputView: View {

    let output: [Int]

    var body: some View {
        Group {
            if output.count != 0 {
                HStack {
                    Text("Output:")
                    ForEach(output.enumerated().map(OutputItem.init)) { item in
                        Text(String(item.value))
                            .padding(4)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                }
            }
        }
    }
}

struct OutputItem {
    let position: Int
    let value: Int
}

extension OutputItem: Identifiable {
    var id: Int { position }
}

