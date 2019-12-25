
import Foundation
import Year2019

do {
    var tool = try IntcodeTool(arguments: CommandLine.arguments)
    try tool.run()
} catch let error as LocalizedError {
    print(error.localizedDescription)
} catch {
    print("There was an unknown error.")
}
