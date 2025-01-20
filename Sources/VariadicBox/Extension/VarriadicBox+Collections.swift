extension VariadicBox {
    public typealias Index = Int
    public typealias Element = Any

    public var startIndex: Int { 0 }
    public var endIndex: Int { count }

    public func index(after i: Int) -> Int { i + 1 }
    
    // Chunks the elements into arrays of specified size
    public func chunked(into size: Int) -> [[Any]] {
        stride(from: 0, to: count, by: size)
            .map {
                Array(array[$0..<Swift.min($0 + size, count)])
            }
    }

    // Safe access with default value
    public func getOrDefault<Output>(_ index: Int, default defaultValue: Output) -> Output {
        get(at: index) ?? defaultValue
    }

    // Type-safe reduce operation
    public func reduce<ReducedType, Result>(
        _ initialResult: Result,
        ofType: ReducedType.Type,
        _ nextPartialResult: (Result, ReducedType) -> Result
    ) -> Result {
        array
            .compactMap { $0 as? ReducedType }
            .reduce(initialResult, nextPartialResult)
    }

    // Group elements by a key
    public func grouped<
        GroupType,
        Key: Hashable
    >(
        ofType: GroupType.Type,
        by keyExtractor: (GroupType) -> Key
    ) -> [Key: [GroupType]] {
        array
            .compactMap { $0 as? GroupType }
            .reduce(into: [:]) { result, element in
                let key = keyExtractor(element)
                result[key, default: []].append(element)
            }
    }
}
