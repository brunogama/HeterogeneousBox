import XCTest
@testable import HeterogeneousBox // Import the module being tested

final class HeterogeneousBoxTests: XCTestCase {

    // MARK: - Initialization Tests

    func testInitializationWithVariadicArguments() {
        let box1 = HeterogeneousBox(1, "hello", true, 3.14)
        XCTAssertEqual(box1.count, 4)
        XCTAssertEqual(box1.getElement(at: 0) as? Int, 1)
        XCTAssertEqual(box1.getElement(at: 1) as? String, "hello")
        XCTAssertEqual(box1.getElement(at: 2) as? Bool, true)
        XCTAssertEqual(box1.getElement(at: 3) as? Double, 3.14)

        let boxEmpty = HeterogeneousBox() // Test empty init
        XCTAssertEqual(boxEmpty.count, 0)
        XCTAssertTrue(boxEmpty.isEmpty)
    }
    
    func testWriteableKeyPathSubscript() {
        var boxCopy = HeterogeneousBox(1, "test")
        boxCopy.0 = 2
        boxCopy.1 = "changed"
    
        XCTAssertEqual(boxCopy.0, 2)
        XCTAssertEqual(boxCopy.1, "changed")
    }

    // MARK: - Count and IsEmpty Tests

    func testCountAndIsEmpty() {
        let box = HeterogeneousBox(1, "test")
        XCTAssertEqual(box.count, 2)
        XCTAssertFalse(box.isEmpty)

        let boxEmpty = HeterogeneousBox()
        XCTAssertEqual(boxEmpty.count, 0)
        XCTAssertTrue(boxEmpty.isEmpty)
    }

    // MARK: - Element Access Tests (Index-Based)

    func testGetElement() {
        let box = HeterogeneousBox(10, false, "world")
        XCTAssertEqual(box.getElement(at: 0) as? Int, 10)
        XCTAssertEqual(box.getElement(at: 1) as? Bool, false)
        XCTAssertEqual(box.getElement(at: 2) as? String, "world")
        // Note: Testing fatalError for out-of-bounds requires specific setups or libraries,
        // so we focus on valid indices here. Checking preconditions is good practice.
        XCTAssertLessThan(2, box.count) // Precondition check
    }
    
    func testGetElementByWriteableKeyPathSubscript() {
        let box = HeterogeneousBox(10, false, "world")
        XCTAssertEqual(box.0, 10)
        XCTAssertEqual(box.1, false)
        XCTAssertEqual(box.2, "world")
        XCTAssertLessThan(2, box.count) // Precondition check
    }

    func testGetTypeInferedElement() {
        let box = HeterogeneousBox(20, true, "swift")
        let intVal: Int = box.getTypeInferedElement(at: 0)
        let boolVal: Bool = box.getTypeInferedElement(at: 1)
        let stringVal: String = box.getTypeInferedElement(at: 2)

        XCTAssertEqual(intVal, 20)
        XCTAssertEqual(boolVal, true)
        XCTAssertEqual(stringVal, "swift")

        // Testing wrong type inference would cause a fatalError (as expected due to as!).
        // Testing out-of-bounds would cause a fatalError (as expected).
    }

    func testSubscriptAny() {
        let box = HeterogeneousBox(30, false, "code")
        XCTAssertEqual(box[0] as? Int, 30)
        XCTAssertEqual(box[1] as? Bool, false)
        XCTAssertEqual(box[2] as? String, "code")
        // Array subscript access will crash on out-of-bounds.
    }

    func testSubscriptTyped() {
        let box = HeterogeneousBox(40, true, "test")
        let intVal: Int = box[typeInfered: 0]
        let boolVal: Bool = box[typeInfered: 1]
        let stringVal: String = box[typeInfered: 2]

        XCTAssertEqual(intVal, 40)
        XCTAssertEqual(boolVal, true)
        XCTAssertEqual(stringVal, "test")

        // Testing wrong type inference would cause a fatalError (as expected due to as!).
        // Testing out-of-bounds would cause a fatalError.
    }

    // MARK: - Computed Property Tests

    func testArrayProperty() {
        let box = HeterogeneousBox(70, "array", true)
        let array = box.array
        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array[0] as? Int, 70)
        XCTAssertEqual(array[1] as? String, "array")
        XCTAssertEqual(array[2] as? Bool, true)

        let boxEmpty = HeterogeneousBox()
        XCTAssertTrue(boxEmpty.array.isEmpty)
    }

    func testNonNilValuesProperty() {
        let strOptional: String? = "hello"
        let intOptional: Int? = nil
        let boolVal: Bool = true

        let box = HeterogeneousBox(strOptional, intOptional, boolVal)
        let nonNil = box.nonNilValues

        XCTAssertEqual(nonNil.count, 2)
        XCTAssertEqual(nonNil[0] as? String, "hello")
        XCTAssertEqual(nonNil[1] as? Bool, true)

        let boxAllNil = HeterogeneousBox(nil as Any?, nil as Any?) // Initialize with two explicit nil optionals
        XCTAssertTrue(boxAllNil.nonNilValues.isEmpty)

        let boxNoNil = HeterogeneousBox(1, "two")
        XCTAssertEqual(boxNoNil.nonNilValues.count, 2)
    }

    // MARK: - Method Tests

    func testReduce() {
        let box = HeterogeneousBox(1, 2, 3, "4") // Note the string "4"
        let sum = box.reduce(0) { result, element in
            if let intValue = element as? Int {
                return result + intValue
            }
            return result // Ignore non-Int types
        }
        XCTAssertEqual(sum, 6) // 1 + 2 + 3 = 6

        let concat = box.reduce("") { $0 + String(describing: $1) }
        XCTAssertEqual(concat, "1234")
    }

    func testFilteredByType() {
        let box = HeterogeneousBox(1, "a", 2, true, "b", 3)
        let ints = box.filteredByType(Int.self)
        let strings = box.filteredByType(String.self)
        let bools = box.filteredByType(Bool.self)
        let doubles = box.filteredByType(Double.self) // Type not present

        XCTAssertEqual(ints, [1, 2, 3])
        XCTAssertEqual(strings, ["a", "b"])
        XCTAssertEqual(bools, [true])
        XCTAssertTrue(doubles.isEmpty)
    }

    func testDump() {
        // Primarily test that it doesn't crash. Output verification is hard.
        let box = HeterogeneousBox(1, "test")
        box.dump()
        // No explicit assertion, just checking for no runtime error.
        XCTAssertTrue(true)
    }
    
    func testEquality() {
        let box1 = HeterogeneousBox(1, "test")
        let box2 = HeterogeneousBox(1, "test")
        let box3 = HeterogeneousBox(2, "test")
        
        XCTAssertEqual(box1, box2)
        XCTAssertNotEqual(box1, box3)
        XCTAssertNotEqual(box2, box3)
    }

}
