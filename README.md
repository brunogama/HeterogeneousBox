
<p align="center">
  <img src=".github/assets/images/IMG_0546.jpg" alt="Banner">
</p>


# HeterogeneousBox

![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrunogama%2FHeterogeneousBox%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brunogama/HeterogeneousBox)[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrunogama%2FHeterogeneousBox%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brunogama/HeterogeneousBox)

A Swift package implementing a type-erased container for variadic parameters, enabling the creation of heterogeneous collections while preserving type information. This experiment leverages Swift Parameter Packs, a powerful feature introduced in Swift 5.9.

## What is HeterogeneousBox?

HeterogeneousBox provides a flexible solution for working with collections of mixed types in Swift without resorting to type erasure through `Any`. Using Swift's Parameter Packs feature, it maintains full type information while allowing you to work with elements of different types within a single collection.

Traditional approaches to heterogeneous collections in Swift often require sacrificing type safety or creating complex type hierarchies. HeterogeneousBox offers an elegant alternative that maintains both flexibility and type safety.

## Features

- **Type-Safe Heterogeneous Collections**: Store elements of different types while preserving their type information
- **Compile-Time Type Checking**: Catch type-related errors at compile time rather than runtime
- **Clean API**: Simple, intuitive interface for working with mixed-type collections
- **Swift Parameter Packs**: Leverages Swift 5.9's parameter packs for improved generic programming
- **Future-Ready**: Designed with Swift 6's upcoming improvements to parameter packs in mind

## Requirements

- Swift 5.9+
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+

## Installation

### Swift Package Manager

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

### Xcode

Alternatively, you can add the package dependency via Xcode:

1. Navigate to File > Add Packages...
2. Enter the repository URL: `https://github.com/brunogama/HeterogeneousBox.git`
3. Set the "Dependency Rule" to "Exact Version" and input `1.0.8`
4. Click "Add Package"

## Usage

### Basic Example

Here's a simple example of how you might use HeterogeneousBox:

```swift
import HeterogeneousBox

// Create a heterogeneous box with different types
let box = HeterogeneousBox.pack(42, "Hello", 3.14, true)

// Access elements with type information preserved
let intValue: Int = box.get(at: 0) // 42
let stringValue: String = box.get(at: 1) // "Hello"
let doubleValue: Double = box.get(at: 2) // 3.14
let boolValue: Bool = box.get(at: 3) // true
```

### Working with Parameter Packs

HeterogeneousBox leverages Swift's parameter packs to create and manipulate collections of mixed types:

```swift
// Function using parameter packs with HeterogeneousBox
func processValues<each T>(values: repeat each T) -> HeterogeneousBox {
    return HeterogeneousBox.pack(repeat each values)
}

// Use with mixed types
let mixedBox = processValues(values: 100, "Swift", 99.9)
```

## How It Works

HeterogeneousBox uses Swift Parameter Packs to create a type-erased container that preserves the original type information. It employs protocol conformances that might appear unconventional due to current Swift language limitations.

The implementation creates a container that can store elements of any type while maintaining their original type information, allowing for type-safe access to the elements.

## Future Developments

Swift 6 will introduce several improvements to parameter packs, including better unpacking and iteration capabilities for runtime-generated tuples. These enhancements will allow for more elegant implementations of heterogeneous collections and may influence future versions of this package.

The upcoming pack iteration feature in Swift 6.0 will make it possible to iterate over the elements of a parameter pack, which will enable more powerful and flexible APIs for working with heterogeneous collections.

## Learn More

For more information about Swift Parameter Packs, check out these resources:

- [WWDC23: Generalize APIs with parameter packs](https://developer.apple.com/videos/play/wwdc2023/10168)
- [Swift Evolution Proposal: Parameter Packs](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0393-parameter-packs.md)
- [Swift.org: Iterate Over Parameter Packs in Swift 6.0](https://www.swift.org/blog/pack-iteration/)

## About

HeterogeneousBox is developed by [Bruno Gama](https://github.com/brunogama), exploring the powerful capabilities of Swift Parameter Packs for type-safe heterogeneous collections.

Check out the blog post about this package: [The Box: Exploring Swift Parameter Packs](https://bruno.foundation/swift/programming/2025/04/13/the-box/)

## License

HeterogeneousBox is available under the MIT license. See the LICENSE file for more info.
