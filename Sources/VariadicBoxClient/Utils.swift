
func separator(_ separator: String = "-", _ count: Int = 80) {
    print((0...count).compactMap { _ in separator }.joined().prefixed(by: "\n").suffixed(by: "\n"))
}

func describer(_ value: Any) {
    print("Type: \(type(of: value))")

    dump(value)
}
