extension HeterogeneousBox: Sequence {
    public struct Iterator: IteratorProtocol {
        private var values: [Any]
        private var index: Int = 0
        
        init(_ box: HeterogeneousBox) {
            self.values = box.array
        }
        
        public mutating func next() -> Any? {
            guard index < values.count else { return nil }
            defer { index += 1 }
            return values[index]
        }
    }
    
    public func makeIterator() -> Iterator {
        Iterator(self)
    }
}
