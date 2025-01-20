import Foundation

struct ServiceKey: Hashable, Sendable {
    let type: ObjectIdentifier
    let argCount: Int
}

final class DIContainer: CustomDebugStringConvertible, @unchecked Sendable {
    private let lock = NSLock()

    private var _typeTable: [ServiceKey: ([Any]) -> Any]
    private(set) var typeTable: [ServiceKey: ([Any]) -> Any] {
        set {
            defer { lock.unlock() }
            lock.lock()
            _typeTable = newValue
        }
        get {
            defer { lock.unlock() }
            lock.lock()
            return _typeTable
        }
    }

    private var _registeredTypes: [ServiceKey: String]
    private(set) var registeredTypes: [ServiceKey: String] {
        set {
            defer { lock.unlock() }
            lock.lock()
            _registeredTypes = newValue
        }
        get {
            defer { lock.unlock() }
            lock.lock()
            return _registeredTypes
        }
    }

    static let shared = DIContainer()

    private init() {
        self._typeTable = [:]
        self._registeredTypes = [:]
    }

    // MARK: - Register Methods (0 to 10 arguments)

    func register<T>(_ type: T.Type, build: @escaping () -> T) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 0)
        typeTable[key] = { _ in build() }
        registeredTypes[key] = "\(type)"
    }

    func register<T, Arg1>(_ type: T.Type, build: @escaping (Arg1) -> T) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 1)
        typeTable[key] = { args in
            guard args.count == 1, let a1 = args[0] as? Arg1 else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1)
        }
        registeredTypes[key] = "\(type) (1 arg)"
    }

    func register<T, Arg1, Arg2>(_ type: T.Type, build: @escaping (Arg1, Arg2) -> T) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 2)
        typeTable[key] = { args in
            guard args.count == 2,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2)
        }
        registeredTypes[key] = "\(type) (2 args)"
    }

    func register<T, Arg1, Arg2, Arg3>(_ type: T.Type, build: @escaping (Arg1, Arg2, Arg3) -> T) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 3)
        typeTable[key] = { args in
            guard args.count == 3,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2,
                let a3 = args[2] as? Arg3
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2, a3)
        }
        registeredTypes[key] = "\(type) (3 args)"
    }

    func register<T, Arg1, Arg2, Arg3, Arg4>(_ type: T.Type, build: @escaping (Arg1, Arg2, Arg3, Arg4) -> T) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 4)
        typeTable[key] = { args in
            guard args.count == 4,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2,
                let a3 = args[2] as? Arg3,
                let a4 = args[3] as? Arg4
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2, a3, a4)
        }
        registeredTypes[key] = "\(type) (4 args)"
    }

    func register<T, Arg1, Arg2, Arg3, Arg4, Arg5>(_ type: T.Type, build: @escaping (Arg1, Arg2, Arg3, Arg4, Arg5) -> T)
    {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 5)
        typeTable[key] = { args in
            guard args.count == 5,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2,
                let a3 = args[2] as? Arg3,
                let a4 = args[3] as? Arg4,
                let a5 = args[4] as? Arg5
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2, a3, a4, a5)
        }
        registeredTypes[key] = "\(type) (5 args)"
    }

    func register<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6>(
        _ type: T.Type,
        build: @escaping (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6) -> T
    ) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 6)
        typeTable[key] = { args in
            guard args.count == 6,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2,
                let a3 = args[2] as? Arg3,
                let a4 = args[3] as? Arg4,
                let a5 = args[4] as? Arg5,
                let a6 = args[5] as? Arg6
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2, a3, a4, a5, a6)
        }
        registeredTypes[key] = "\(type) (6 args)"
    }

    func register<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7>(
        _ type: T.Type,
        build: @escaping (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7) -> T
    ) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 7)
        typeTable[key] = { args in
            guard args.count == 7,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2,
                let a3 = args[2] as? Arg3,
                let a4 = args[3] as? Arg4,
                let a5 = args[4] as? Arg5,
                let a6 = args[5] as? Arg6,
                let a7 = args[6] as? Arg7
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2, a3, a4, a5, a6, a7)
        }
        registeredTypes[key] = "\(type) (7 args)"
    }

    func register<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8>(
        _ type: T.Type,
        build: @escaping (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8) -> T
    ) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 8)
        typeTable[key] = { args in
            guard args.count == 8,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2,
                let a3 = args[2] as? Arg3,
                let a4 = args[3] as? Arg4,
                let a5 = args[4] as? Arg5,
                let a6 = args[5] as? Arg6,
                let a7 = args[6] as? Arg7,
                let a8 = args[7] as? Arg8
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2, a3, a4, a5, a6, a7, a8)
        }
        registeredTypes[key] = "\(type) (8 args)"
    }

    func register<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9>(
        _ type: T.Type,
        build: @escaping (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9) -> T
    ) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 9)
        typeTable[key] = { args in
            guard args.count == 9,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2,
                let a3 = args[2] as? Arg3,
                let a4 = args[3] as? Arg4,
                let a5 = args[4] as? Arg5,
                let a6 = args[5] as? Arg6,
                let a7 = args[6] as? Arg7,
                let a8 = args[7] as? Arg8,
                let a9 = args[8] as? Arg9
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2, a3, a4, a5, a6, a7, a8, a9)
        }
        registeredTypes[key] = "\(type) (9 args)"
    }

    func register<T, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10>(
        _ type: T.Type,
        build: @escaping (Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10) -> T
    ) {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 10)
        typeTable[key] = { args in
            guard args.count == 10,
                let a1 = args[0] as? Arg1,
                let a2 = args[1] as? Arg2,
                let a3 = args[2] as? Arg3,
                let a4 = args[3] as? Arg4,
                let a5 = args[4] as? Arg5,
                let a6 = args[5] as? Arg6,
                let a7 = args[6] as? Arg7,
                let a8 = args[7] as? Arg8,
                let a9 = args[8] as? Arg9,
                let a10 = args[9] as? Arg10
            else {
                fatalError("Incorrect arguments when resolving \(type)")
            }
            return build(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
        }
        registeredTypes[key] = "\(type) (10 args)"
    }

    // MARK: - Resolve Methods (0 to 10 arguments)

    func resolve<T>(_ type: T.Type) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 0)
        guard let factory = typeTable[key] else { return nil }
        return factory([]) as? T
    }

    func resolve<T, Arg1>(_ type: T.Type, _ arg1: Arg1) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 1)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1]) as? T
    }

    func resolve<T, Arg1, Arg2>(_ type: T.Type, _ arg1: Arg1, _ arg2: Arg2) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 2)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2]) as? T
    }

    func resolve<T, Arg1, Arg2, Arg3>(_ type: T.Type, _ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 3)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2, arg3]) as? T
    }

    func resolve<T, Arg1, Arg2, Arg3, Arg4>(
        _ type: T.Type,
        _ arg1: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4
    ) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 4)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2, arg3, arg4]) as? T
    }

    func resolve<
        T,
        Arg1,
        Arg2,
        Arg3,
        Arg4,
        Arg5
    >(
        _ type: T.Type,
        _ arg1: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4,
        _ arg5: Arg5
    ) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 5)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2, arg3, arg4, arg5]) as? T
    }

    func resolve<
        T,
        Arg1,
        Arg2,
        Arg3,
        Arg4,
        Arg5,
        Arg6
    >(
        _ type: T.Type,
        _ arg1: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4,
        _ arg5: Arg5,
        _ arg6: Arg6
    ) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 6)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2, arg3, arg4, arg5, arg6]) as? T
    }

    func resolve<
        T,
        Arg1,
        Arg2,
        Arg3,
        Arg4,
        Arg5,
        Arg6,
        Arg7
    >(
        _ type: T.Type,
        _ arg1: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4,
        _ arg5: Arg5,
        _ arg6: Arg6,
        _ arg7: Arg7
    ) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 7)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2, arg3, arg4, arg5, arg6, arg7]) as? T
    }

    func resolve<
        T,
        Arg1,
        Arg2,
        Arg3,
        Arg4,
        Arg5,
        Arg6,
        Arg7,
        Arg8
    >(
        _ type: T.Type,
        _ arg1: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4,
        _ arg5: Arg5,
        _ arg6: Arg6,
        _ arg7: Arg7,
        _ arg8: Arg8
    ) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 8)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8]) as? T
    }

    func resolve<
        T,
        Arg1,
        Arg2,
        Arg3,
        Arg4,
        Arg5,
        Arg6,
        Arg7,
        Arg8,
        Arg9
    >(
        _ type: T.Type,
        _ arg1: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4,
        _ arg5: Arg5,
        _ arg6: Arg6,
        _ arg7: Arg7,
        _ arg8: Arg8,
        _ arg9: Arg9
    ) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 9)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9]) as? T
    }

    func resolve<
        T,
        Arg1,
        Arg2,
        Arg3,
        Arg4,
        Arg5,
        Arg6,
        Arg7,
        Arg8,
        Arg9,
        Arg10
    >(
        _ type: T.Type,
        _ arg1: Arg1,
        _ arg2: Arg2,
        _ arg3: Arg3,
        _ arg4: Arg4,
        _ arg5: Arg5,
        _ arg6: Arg6,
        _ arg7: Arg7,
        _ arg8: Arg8,
        _ arg9: Arg9,
        _ arg10: Arg10
    ) -> T? {
        let key = ServiceKey(type: ObjectIdentifier(type), argCount: 10)
        guard let factory = typeTable[key] else { return nil }
        return factory([arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10]) as? T
    }

    // MARK: - Printing Support
    var debugDescription: String {
        var description = "ContainerSimulation Registrations:\n"
        for (key, typeName) in registeredTypes {
            description += "- \(typeName) [argCount: \(key.argCount)]\n"
        }
        return description
    }
}
