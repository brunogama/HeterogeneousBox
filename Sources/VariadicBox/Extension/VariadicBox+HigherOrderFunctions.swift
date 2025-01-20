
public func map<Output>(_ transform: (Any) -> Output) -> [Output] {
    array.map(transform)
}

public func compactMap<Output>(_ transform: (Any) -> Output?) -> [Output] {
    array.compactMap(transform)
}

public func filter(_ isIncluded: (Any) -> Bool) -> [Any] {
    array.filter(isIncluded)
}

public func contains<Parameter>(where predicate: (Parameter) -> Bool) -> Bool {
    array.compactMap { $0 as? Parameter }.contains(where: predicate)
}
