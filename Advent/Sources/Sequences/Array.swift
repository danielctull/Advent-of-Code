
extension Array {

    public mutating func filtered(_ isIncluded: (Element) -> Bool) {
        self = filter(isIncluded)
    }
}
