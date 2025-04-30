import Foundation

extension HeterogeneousBox: Hashable
where repeat each Value: Hashable,
      repeat each Value : Equatable {
    public func hash(into hasher: inout Hasher) {
        repeat hasher.combine(each value)
    }
}
