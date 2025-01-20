import VariadicBox
import Foundation
//simpleSample()
//separator()


// A Box, quantos daqui já precisaram de algum dia utilizar alguma forma de wrapper para esconder o tipo interno em uma lista que precisa ser homogênema?
// Bem a Box que conhecemos a alguns anos atrá era de definida da segunda forma.
// struct Box<V> {
//   let value: V
// }
//
// Vocês já podem ter visto boxes de outras formas como por exempl
// struct Box<V> {
//   var value: V {
//      didSet { bind(value) }
//   }
//   completion: ((V) -> ())?
//   init(
//       _ value: V,
//       bind: ((V) -> ())?
//    ) {
//      self.value = self.value
//      self.bind = completion
//    }
//
// Existem muitas maneiras de representar entiddades heterogeneas na computação. Pra quem é do Funcional existe por exemplo o tipo Either<U,T>
//swinjectLikeSampleSimulation()
//
//
//protocol SampleProtocol: Sendable {
//    func execute()
//}
//
//final class Sample: SampleProtocol {
//
//    let a: Int
//    let b: UUID
//
//    init(
//        a: Int,
//        b: UUID
//    ) {
//        self.a = a
//        self.b = b
//        print("Sample init")
//    }
//
//    func execute() {
//        print("Executing Sample")
//        print("a: \(a)")
//        print("b: \(b)")
//    }
//}
//
//DIContainer.shared.register(SampleProtocol.self) { a, b in
//    Sample(a: a, b: b)
//}
//
//struct Test: Sendable {
//    @Injected(25, UUID()) var usecase: SampleProtocol
//    @Injected(Int.random(in: 1...1_000), String.randomized(100)) var usecase2: UsecaseProtocol
//}
//
//let test = Test()
//
//dump(test)
//
//separator()
//
//test.usecase.execute()
//
//protocol AService: Sendable {}
//
//final class ServiceImp: AService {
//    init(){}
//}
//
//DIContainer.shared.register(AService.self) {
//    ServiceImp()
//}
//
//@TaskLocal let direct = Injected<AService, Never>()
//func wrongUsage() -> AService {
//    @Injected() var temp: AService
//    return temp
//}
//
//// ❌ Invalid: Closure
//let closure = {
//    @Injected() var service: AService  // Error with helpful message
//}
//
//// ❌ Invalid: Higher-order function
//let array = [1, 2, 3]
//array.map { item in
//    @Injected() var service: AService  // Error with helpful message
//}
//
//// ❌ Invalid: Local variable in function
//func wrong() {
//    @Injected() var service: AService  // Error with helpful message
//}
//
//
//protocol PropertyTestingProtocol {
//    associatedtype AValue
//    var description: String { get }
//}
//extension PropertyTestingProtocol {
//    var description: String {
//        String(describing: Self.self)
//    }
//}
// Basic parameter pack usage`

import Foundation

func concatenate<each T>(_ values: repeat each T) -> String {
    "\(Array(Mirror(reflecting: (repeat each values)).mirror.children))"
}

// Using parameter packs with type constraints
func sumNumeric<each T: Numeric>(_ values: repeat each T) -> T {
    (repeat each values) + 0
}

// Multiple parameter packs in a single function
func zip<each T, each U>(_ first: repeat each T, _ second: repeat each U) -> [(each T, each U)] {
    [(repeat (each first, each second))]
}

// Parameter packs with where clauses
func printComparable<each T: Comparable>(values: repeat each T) where (repeat each T) == Int {
    print(values)
}

// Parameter packs in generic types
struct Tuple<each Element> {
    var values: (repeat each Element)
    
    init(_ values: repeat each Element) {
        self.values = (repeat each values)
    }
}

// Example usage:
let concatenated = concatenate("Hello", " ", "World") // "Hello World"
let sum = sumNumeric(1, 2, 3, 4, 5) // 15
let zipped = zip([1, 2, 3], ["a", "b", "c"]) // [(1, "a"), (2, "b"), (3, "c")]

// Using parameter packs with protocols
protocol Container<each Element> {
    associatedtype Storage = (repeat each Element)
    var storage: Storage { get set }
}

struct PackContainer<each T>: Container {
    var storage: (repeat each T)
}

// Parameter packs with result builders
@resultBuilder
struct ArrayBuilder<each T> {
    static func buildBlock(_ components: repeat [each T]) -> [repeat each T] {
        [repeat each components]
    }
}

// Using parameter packs with property wrappers
@propertyWrapper
struct Packed<each T> {
    var wrappedValue: (repeat each T)
    
    init(wrappedValue: repeat each T) {
        self.wrappedValue = (repeat each wrappedValue)
    }
}

class Example {
    @Packed var values: (Int, String, Double) = (42, "Hello", 3.14)
}

// Parameter packs with generic constraints and associated types
protocol Transformable {
    associatedtype Output
    func transform() -> Output
}

func transformAll<each T: Transformable>(_ values: repeat each T) -> (repeat each T.Output) {
    (repeat each values.transform())
}
