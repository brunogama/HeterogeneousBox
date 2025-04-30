import Foundation

// Extension for CustomStringConvertible conformance
extension HeterogeneousBox: CustomStringConvertible {
    public var description: String {
        let elements = array.map { String(describing: $0) }.joined(separator: ", ")
        return "HeterogeneousBox(\(elements))"
    }
}

// Extension for CustomDebugStringConvertible conformance
extension HeterogeneousBox: CustomDebugStringConvertible {
    public var debugDescription: String {
        let typeName = String(describing: type(of: self))
        let elements = array.map { element in
            let elementType = type(of: element)
            return "\(String(describing: element)) (\(elementType))"
        }.joined(separator: ", ")
        
        return "\(typeName) { \(elements) }"
    }
}
