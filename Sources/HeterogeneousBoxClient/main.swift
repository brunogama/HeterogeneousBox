import HeterogeneousBox
import Foundation

let box = HeterogeneousBox(1, true, "a")
print(box)
box.dump()
let element = box.getElement(at: 6)
print("element: \(element), type: \(type(of: element))")
let element2: Bool = box.getTypeInferedElement(at: 1)
print("element: \(element2), type: \(type(of: element2))")

