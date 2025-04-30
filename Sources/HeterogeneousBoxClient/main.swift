import HeterogeneousBox
import Foundation

func separate() {
    print("=====================================")
}

var box = HeterogeneousBox(1, true, "a")
print(box)
separate()
box.dump()

let element = box.getElement(at: 2)
print("element: \(element), type: \(type(of: element))")
separate()

let element2: Bool = box.getTypeInferedElement(at: 1)
print("element: \(element2), type: \(type(of: element2))")
separate()

// As array
let array = box.array
print("array: \(array), type: \(type(of: array))")

// Reduce
let reduced = box.reduce("") { $0 + String(describing: $1) }
print("reduced: \(reduced), type: \(type(of: reduced))")

// Filter
let filtered = box.filteredByType(Int.self)
print("filtered: \(filtered), type: \(type(of: filtered))")

// Non nil values
let nonNilValues = box.nonNilValues
print("nonNilValues: \(nonNilValues), type: \(type(of: nonNilValues))")
separate()

// Equality REMOVED / NEEDS REWORK (Depends on internal structure)
/*
let box4 = HeterogeneousBox(1, true, "a")
print("box4: \(box4)")
print("box == box4: \(box == box4)")
// print("box3 == box4: \(box3 == box4)") // Compile time error not same type
*/
separate()

// Test new protocol conformances REMOVED / NEEDS REWORK

print("Testing new protocol conformances")
separate()

// Test CustomStringConvertible
print("CustomStringConvertible output:")
print(box.description)
separate()

// Test CustomDebugStringConvertible
print("CustomDebugStringConvertible output:")
print(box.debugDescription)
separate()

// Test Collection functionality
print("Collection functionality:")
print("First element: \(box.first ?? "None")")
// print("Last element: \(box.last ?? "None")")
print("Map operation: \(box.map { "Item: \($0)" })")
separate()

// Test Comparable functionality REMOVED

// Test array index access (Collection protocol)
print("Array index access:")
for i in box.indices {
    print("Element at index \(i): \(box[i])")
}
separate()

// Test CustomReflectable
print("CustomReflectable with Mirror:")
dump(Mirror(reflecting: box))
separate()

