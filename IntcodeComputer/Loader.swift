
import Year2019
import SwiftUI

struct Loader: View {

    let handler: ([Int]) -> ()
    @State var intcode = ""

    func load() {
        let code = intcode
            .components(separatedBy: ",")
            .compactMap(Int.init)
        handler(code)
    }

    var body: some View {
        VStack {
            TextField("Intcode", text: $intcode)
                .font(.custom("SF Mono", size: 14))
            Button(action: load) { Text("Load") }
        }
    }
}
