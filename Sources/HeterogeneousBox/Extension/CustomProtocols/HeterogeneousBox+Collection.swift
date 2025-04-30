import Foundation

// Extension for Collection protocol conformance
extension HeterogeneousBox: Collection {
    public typealias Index = Int
    public typealias Element = Any
    
    public var startIndex: Index {
        return 0
    }
    
    public var endIndex: Index {
        return count
    }
    
    public func index(after i: Index) -> Index {
        return i + 1
    }
    
    // No need to reimplement subscript as it's already defined in the base implementation
    
    // Additional helpful methods that work well with Collection
    
    public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        return try array.map(transform)
    }
    
    public func compactMap<T>(_ transform: (Element) throws -> T?) rethrows -> [T] {
        return try array.compactMap(transform)
    }
    
    public func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        return try array.filter(isIncluded)
    }
    
    public func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        return try array.first(where: predicate)
    }
}
