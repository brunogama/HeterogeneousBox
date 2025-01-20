//
//  UncheckedSendable.swift
//  VariadicBox
//
//  Created by Bruno da Gama Porciuncula on 19/01/25.
//

@propertyWrapper
public struct UncheckedSendable<Value>: @unchecked Sendable {
    public var wrappedValue: Value
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
