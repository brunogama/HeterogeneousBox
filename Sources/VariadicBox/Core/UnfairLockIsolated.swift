import Foundation
import os.lock

/// A property wrapper that provides high-performance thread-safe access using os_unfair_lock.
///
/// `UnfairLockIsolated` provides the highest performance synchronization using the lightweight `os_unfair_lock`.
@propertyWrapper
public struct UnfairLockIsolated<Value: Sendable>: @unchecked Sendable {
    private var _wrappedValue: _UnfairLockIsolated<Value>
    private let lock: os_unfair_lock_t

    /// Creates a new synchronized value.
    /// - Parameter wrappedValue: The initial value to store.
    public init(wrappedValue: Value) {
        self._wrappedValue = _UnfairLockIsolated<Value>(wrappedValue)
        self.lock = .allocate(capacity: 1)
        self.lock.initialize(to: os_unfair_lock())
    }

    /// The synchronized value.
    ///
    /// Access to this value is automatically synchronized using an os_unfair_lock.
    public var wrappedValue: Value {
        get { _wrappedValue.withLock { $0 } }
        set { _wrappedValue.withLock { $0 = newValue } }
    }
}
