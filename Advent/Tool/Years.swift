
import Advent
import Year2020

let years: [Year.Type] = [
    Year2020.self
]

func getYear(at index: Int) throws -> Year.Type {
    struct UnknownYear: Error {}
    switch index {
    case 2020: return Year2020.self
    default: throw UnknownYear()
    }
}
struct UnknownDay: Error {}
extension Year {

    static func day(at index: Int) throws -> Day.Type {
        switch index {
        case ...0: throw UnknownDay()
        case 26...: throw UnknownDay()
        default: return days[index]
        }
    }
}
