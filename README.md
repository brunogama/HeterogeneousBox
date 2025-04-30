# HeterogeneousBox

An experiment utilizing Swift Parameter Packs, a feature introduced in Swift 5.9. This package demonstrates an implementation of a type-erased container for variadic parameters, enabling the creation of heterogeneous collections.

The required protocol conformances might seem unconventional due to current language limitations. Swift 6 includes several proposals aimed at improving the unpacking and iteration capabilities for runtime-generated tuples using parameter packs.

For more information, check the [ "Generalize APIs with parameter packs"](https://developer.apple.com/videos/play/wwdc2023/10168) introducing the feature.

## Installation

To add HeterogeneousBox to your Swift project using Swift Package Manager, declare it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/brunogama/HeterogeneousBox.git", .exact("1.0.8"))
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["HeterogeneousBox"]),
    // ... other targets
]
```

Then, execute `swift package resolve` in your terminal.

Alternatively, you can add the package dependency via Xcode:
1. Navigate to File > Add Packages...
2. Enter the repository URL: `https://github.com/brunogama/HeterogeneousBox.git`
3. Set the "Dependency Rule" to "Exact Version" and input `1.0.8`.
4. Click "Add Package".
