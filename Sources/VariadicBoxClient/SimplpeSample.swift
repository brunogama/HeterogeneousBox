//
//  SimplpeSample.swift
//  VariadicBox
//
//  Created by Bruno on 13/12/24.
//

import Foundation
import VariadicBox

func simpleSample() {
    enum Spam: String {
        case eggs
        case bacon
        case sausage
    }

    let aFunction: @Sendable () -> Void = {
        print("Whats the terminal velocity of unladen swallow?")
    }
    var boxedParameterPacks = VariadicBox(1, "Hello", 3.14, UUID(), 1...4, "World", aFunction, Spam.bacon)

    // Dump of VariadicBox:
    dump(boxedParameterPacks)
    separator()

    // VariadicBox allows the developer to use dynamicMemberLookup
    print("box.0: \(boxedParameterPacks.0)")
    print("box.1: \(boxedParameterPacks.1)")
    print("box.2: \(boxedParameterPacks.2)")
    print("box.3: \(boxedParameterPacks.3)")
    print("box.4: \(boxedParameterPacks.4)")
    separator()

    // Every index is writable
    // Values are updated 
    print("box.0: \(boxedParameterPacks.0)")
    print("box.1: \(boxedParameterPacks.1)")
    boxedParameterPacks.0 = 2
    boxedParameterPacks.1 = "World"
    print("box.0: \(boxedParameterPacks.0)")
    print("box.1: \(boxedParameterPacks.1)")
    separator()

    // Setting a different type will raise compiler error
    // boxedParameterPacks.0 = 3.14 // Compiler error
//    boxedParameterPacks.0 = 3.14

    // You can name the indexes
    
    separator()

    // VariadicBox has a count property
    print("box.count: \(boxedParameterPacks.count)")
    separator()

    // Variadic box has map, compactMap, contains, filter
    // Mapping all values to the string box.map { "|----> \($0) <----|" }
    print("\n")
    print(boxedParameterPacks.map { "|----> \($0) <----|"}.joined(separator: "\n"))
    separator()

    // Filtering all the strings
    // box.filter { $0 is String }
    print(boxedParameterPacks.filter { $0 is String })
    separator()

    // Checking if the box contains a string
    // box.contains { $0 is String }
    print(boxedParameterPacks.contains { $0 is String })
    separator()

    // Reducing the box to a single value
    // box.reduce(0) { $0 + ($1 as? Int ?? 0) }
    print(boxedParameterPacks.reduce(0) { $0 + ($1 as? Int ?? 0) })
    separator()

    // Is possible to Iterate over the parameter values
    for (i, v) in boxedParameterPacks.makeIterator().enumerated() {
        print("Index/Value/Type \(i) = \(v), type: \(type(of: v))")
        separator()
    }
    separator()

    // VariadicBox can store functions and closures
    boxedParameterPacks.6()
}
