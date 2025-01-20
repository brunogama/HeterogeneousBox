import VariadicBox
import Foundation


protocol UsecaseProtocol: Sendable {
    func execute()
}

final class Usecase: UsecaseProtocol, CustomStringConvertible {
    var description: String {
        "Usecase[par1=\(par1), par2=\(par2)]"
    }

    let par1: Int
    let par2: String

    init(par1: Int, par2: String) {
        self.par1 = par1
        self.par2 = par2
    }

    func execute() {
        print("Executing Usecase")
        print("\(self.description)")
    }
}

protocol ServiceProtocol {
    func execute()
}

class Service: ServiceProtocol, CustomStringConvertible {
    var description: String {
        "Service[usecase=\(usecase), par1=\(par1), par2=\(par2)]"
    }

    let usecase: UsecaseProtocol
    let par1: Int
    let par2: String

    init(usecase: UsecaseProtocol, par1: Int, par2: String) {
        self.usecase = usecase
        self.par1 = par1
        self.par2 = par2
    }

    func execute() {
        print("Executing Service")
        print("\(self.description)")
    }
}

protocol Foo {}

class FooImpl: Foo {
    let a: Int

    init(a: Int) {
        self.a = a
    }
}

func swinjectLikeSampleSimulation() {

    let container = DIContainer.shared

    container.register(UsecaseProtocol.self) { a, b in
        Usecase(par1: a, par2: b)
    }

    let resolve = container.resolve
    

//    let usecase = container.resolve(
//        UsecaseProtocol.self,
//        boxA.0,
//        boxA.1
//    )!

    separator()
    describer(usecase)
    usecase.execute()

    container.register(ServiceProtocol.self) { a, b, c in
        Service(usecase: a, par1: b, par2: c)
    }

    let boxB = VariadicBox(
        usecase,
        Int.random(in: 0...Int.max),
        String.randomized(Int.random(in: 10...20))
    )

    let service = container.resolve(
        ServiceProtocol.self,
        boxB.0,
        boxB.1,
        boxB.2
    )!

    separator()
    describer(service)
    service.execute()
    separator()
    print(container)
    separator()


    container.register(Foo.self) { a in
        FooImpl(a: a)
    }

    let boxC = VariadicBox(42.1)

    // Crashes container. Not same argument registered
    if false {
        print(container.resolve(Foo.self, boxC.0)!)
    }
}


import Foundation

@available(macOS 10.15, iOS 15.0, tvOS 13.0, watchOS 6.0, *)
@dynamicMemberLookup
public struct AVariadicBox<each Value, T>: Sendable
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
