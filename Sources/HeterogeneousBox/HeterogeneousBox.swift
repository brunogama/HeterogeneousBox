import Foundation

@dynamicMemberLookup
public struct HeterogeneousBox<each Value> {
    public private(set) var value: (repeat each Value)
    
    public init(_ value: repeat each Value) {
        self.value = (repeat each value)
    }
    
    public init(_ tuple: (repeat each Value)) {
        self.value = tuple
    }
    
    public subscript(position: Int) -> Any {
        get {
            array[position]
        }
    }
    
    public func getElement(at position: Int) -> Any {
        if position >= count {
            fatalError("Index out of bounds")
        }
        
        var count = 0
        for element in repeat each value {
            if count == position {
                return element
            }
            count += 1
        }
        
        fatalError(
            "Could not find element at position \(position)"
        )
    }
    
    public func getTypeInferedElement<T>(at position: Int) -> T {
        if position >= count {
            fatalError("Index out of bounds")
        }
        
        var count = 0
        for element in repeat each value {
            if count == position {
                return element as! T
            }
            count += 1
        }
        
        fatalError(
            "Could not find element at position \(position)"
        )
    }
    
    public subscript<U>(typeInfered position: Int) -> U {
        get {
            array[position] as! U
        }
    }
    
    public subscript<Output>(
        dynamicMember keyPath: WritableKeyPath<(repeat each Value), Output>
    ) -> Output {
        get { value[keyPath: keyPath] }
        set { value[keyPath: keyPath] = newValue }
    }
    
    public var count: Int {
        array.count
    }
    
    public var isEmpty: Bool {
        count == 0
    }
    
    public var array: [Any] {
        Array(Mirror(reflecting: value).children.map(\.value))
    }
    
    public func reduce<Result>(
        _ initialResult: Result,
        _ nextPartialResult: (Result, Any) throws -> Result
    ) rethrows -> Result {
        try array.reduce(initialResult, nextPartialResult)
    }
    
    public var nonNilValues: [Any] {
        array.compactMap { value in
            if let optional = value as? OptionalType, optional.isNil {
                return nil
            }
            return value
        }
    }
    
    public func dump() {
        Swift.dump(value)
    }
    
    public func filteredByType<T>(_ type: T.Type) -> [T] {
        array.compactMap { $0 as? T }
    }
    
    @discardableResult
    func append<T>(value: T) -> HeterogeneousBox<(repeat each Value, T)> {
        let values = ((repeat each self.value, value))
        return HeterogeneousBox<(repeat each Value, T)>.init(values)
    }
    @discardableResult
    public func appending<each T>(
        values: repeat each T
    ) -> HeterogeneousBox<(repeat each Value, repeat each T)> {
        HeterogeneousBox<(repeat each Value, repeat each T)>.init((repeat each value, repeat each values))
    }
}

private protocol OptionalType {
    var isNil: Bool { get }
}

extension Optional: OptionalType {
    var isNil: Bool { self == nil }
}
