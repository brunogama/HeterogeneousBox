//
//  PropertyContextKey.swift
//  VariadicBox
//
//  Created by Bruno on 13/12/24.
//

import VariadicBox
import Foundation

// Key type for property context validation
private protocol PropertyContextKey: Sendable {
    static var isPropertyContext: Bool { get set }
//    static var shared: InjectionContextKey { get }
}

// Global property context state
private struct InjectionContextKey: PropertyContextKey {
    private static let queue = DispatchQueue(
        label: "Injection-Context-Key",
        qos: .userInteractive
    )
    nonisolated(unsafe) private static var _isPropertyContext: Bool = false
    static var isPropertyContext: Bool {
        get { queue.sync { _isPropertyContext } }
        set { queue.sync { _isPropertyContext = newValue } }
    }
//    var isPropertyContext: Bool = false
//    nonisolated(unsafe) public static var shared = InjectionContextKey()
}

public enum InjectedError: Error {
    case invalidUsage(
        message: String,
        callSite: String,
        line: Int,
        properUsageExample: String
    )

    var localizedDescription: String {
        switch self {
        case .invalidUsage(let message, let callSite, let line, let example):
            return """
            [@Injected] Error: \(message)
            Call site: \(callSite):\(line)
            
            Proper usage example:
            \(example)
            
            Note: @Injected can only be used as a property wrapper in type declarations.
            """
        }
    }
}
@propertyWrapper
public struct Injected<Value: Sendable, each Parameter: Sendable>: Sendable {
    public private(set) var wrappedValue: Value

    @available(*, unavailable, message: """
        @Injected can only be used as a property wrapper.
        
        ✅ Valid:
        struct Example {
            @Injected var service: Service
            @Injected(param1, param2) var paramService: Service
        }
        
        ❌ Invalid:
        let service = Injected<Service>()
        func wrong() {
            @Injected var service: Service
        }
        """)
    public init() {
        fatalError("@Injected can only be used as a property wrapper")
    }

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    public init(name: String? = nil) {
        let semaphore = DispatchSemaphore(value: 0)
        var resolvedValue: Value?

        Task {
            resolvedValue = await MainActor.run {
                DIContainer.shared.resolve(Value.self)!
            }
            semaphore.signal()
        }

        semaphore.wait()
        self.wrappedValue = resolvedValue!
    }

    public init(
        name: String? = nil,
        _ argument: repeat each Parameter
    ) {
        let semaphore = DispatchSemaphore(value: 0)
        var resolvedValue: Value?

        let box = VariadicBox<repeat each Parameter>(repeat each argument)
        let totalParameters = box.count

        Task {
            resolvedValue = await MainActor.run {
                let resolver = DIContainer.shared
                let args = Array(arrayLiteral: box)
                return resolver.typeTable[
                    ServiceKey(type: ObjectIdentifier(Value.self), argCount: totalParameters)
                ]?(args) as? Value ?? {
                    fatalError("""
                    Failed to resolve \(Value.self) with \(totalParameters) parameters.
                    Make sure the service is registered in DIContainer.
                    """)
                }()
            }
            semaphore.signal()
        }

        semaphore.wait()
        self.wrappedValue = resolvedValue!
    }

    public init<Wrapped: Sendable>(
        name: String? = nil,
        _ argument: repeat each Parameter
    ) where Value == Optional<Wrapped> {
        let semaphore = DispatchSemaphore(value: 0)
        var resolvedValue: Value?

        Task {
            resolvedValue = await MainActor.run {
                DIContainer.shared.resolve(Wrapped.self)
            }
            semaphore.signal()
        }

        semaphore.wait()
        self.wrappedValue = resolvedValue!
    }
}
