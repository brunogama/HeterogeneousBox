import Foundation

@available(macOS 10.15, iOS 15.0, tvOS 13.0, watchOS 6.0, *)
@dynamicMemberLookup
public struct VariadicBox<each Value>: Sendable
where repeat each Value: Sendable {
    @UncheckedSendable
    @UnfairLockIsolated
    private var value: (repeat each Value)

    public init(_ value: repeat each Value) {
        self.value = (repeat each value)
    }

    public subscript(position: Int) -> Any {
        get {
            let mirror = Mirror(reflecting: value)
            let children = Array(mirror.children)
            return children[position].value
        }
    }

    public subscript<U>(typeInfered position: Int) -> U {
        get {
            let mirror = Mirror(reflecting: value)
            let children = Array(mirror.children)
            return children[position].value as! U
        }
    }

    public subscript<Output>(
        dynamicMember keyPath: WritableKeyPath<(repeat each Value), Output>
    ) -> Output {
        get { value[keyPath: keyPath] }
        set { value[keyPath: keyPath] = newValue }
    }

    public var count: Int {
        var count: Int = 0
        func c<C>(_ arg: C) {
            count += 1
        }
        repeat c(each value)
        return count
    }

    public var isEmpty: Bool {
        count == 0
    }

    public var array: [Any] {
        Array(Mirror(reflecting: value).children.map(\.value))
    }

    public var description: String {
        let mirror = Mirror(reflecting: value)
        return mirror.children.map { "\($0.value)" }.joined(separator: ", ")
    }

    public func get<Output>(at index: Int) -> Output? {
        self[index] as? Output
    }
}

public protocol CustomNamedStringConvertible {
    var namedDescription: String { get }
}
