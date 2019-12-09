
import Year2019
import SwiftUI

struct RegistersView: View {

    let computer: IntcodeComputer

    var body: some View {
        CollectionView(data: computer.registers, layout: flowLayout) { register in
//        HStack {
//            ForEach(computer.registers) { register in
                VStack(spacing: 4) {

                    Text(verbatim: "\(register.value)")
                        .font(.custom("SF Mono", size: 14))
                        .padding(4)
                        .background(self.computer.instructionPointer == register.position ? Color.yellow : Color.white)
                        .cornerRadius(4)

                    Text(verbatim: "\(register.position)")
                        .font(.custom("SF Mono", size: 10))
                }
//            }
        }
    }
}

extension IntcodeComputer {

    var registers: [Register] {
        code.enumerated().map(Register.init)
    }
}

struct Register {
    let position: Int
    let value: Int
}

extension Register: Identifiable {
    var id: Int { position }
}
