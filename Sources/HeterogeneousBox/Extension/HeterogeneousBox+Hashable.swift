extension HeterogeneousBox: Hashable where repeat each Value: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        var areEqual = true
        func checkEquality<T: Equatable>(_ lhs: T, _ rhs: T) {
            lhs == rhs ? () : (areEqual = false)
        }
        repeat checkEquality(each lhs.value, each rhs.value)
        return areEqual
    }

    public func hash(into hasher: inout Hasher) {
        repeat hasher.combine(each value)
    }
}
