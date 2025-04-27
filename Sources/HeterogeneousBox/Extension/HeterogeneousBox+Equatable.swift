import Foundation

extension HeterogeneousBox: Equatable where repeat each Value: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        var areEqual = true
        func checkEquality<T: Equatable>(_ lhs: T, _ rhs: T) {
            lhs == rhs ? () : (areEqual = false)
        }
        repeat checkEquality(each lhs.value, each rhs.value)
        return areEqual
    }
    
    public func contains<T>(
        where value: T
    ) -> Bool where T: Equatable {
        array.contains(where: { $0 as? T == value })
    }
}

