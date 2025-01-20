import Foundation
import os.lock

@usableFromInline
final class _UnfairLockIsolated<Value>: @unchecked Sendable {
    private var _value: Value
    private let lock: os_unfair_lock_t

    @usableFromInline
    init(_ value: @autoclosure @Sendable () throws -> Value) rethrows {
        self._value = try value()
        self.lock = .allocate(capacity: 1)
        self.lock.initialize(to: os_unfair_lock())
    }
    @usableFromInline
    func withLock<T: Sendable>(
        _ operation: @Sendable (inout Value) throws -> T
    ) rethrows -> T {
        os_unfair_lock_lock(lock)
        defer { os_unfair_lock_unlock(lock) }
        var value = _value
        defer { _value = value }
        return try operation(&value)
    }
    
    deinit {
        lock.deinitialize(count: 1)
        lock.deallocate()
    }
}
