
extension String {
    static func randomized(_ size: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<size).map { _ in letters.randomElement()! })
    }
    
    func prefixed(by prefix: String) -> String {
        "\(prefix)\(self)"
    }

    func suffixed(by suffix: String) -> String {
        "\(self)\(suffix)"
    }

    func surrounded(by prefix: String, and suffix: String) -> String {
        prefixed(by: prefix)
            .suffixed(by: suffix)
    }

    func surrounded(by string: String) -> String {
        prefixed(by: string)
            .suffixed(by: string)
    }
}
