import Foundation

extension HeterogeneousBox: Equatable
where repeat each Value: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        func checkEquality<LT: Equatable, RT: Equatable>(_ leftValue: LT, _ rightValue: RT) throws {
            
            guard type(of: leftValue) == type(of: rightValue),
                  leftValue == rightValue as! LT
            else {
                throw NSError(domain: "Type mismatch or values not equal", code: 0, userInfo: nil)
            }
            print("Comparing \(leftValue) and \(rightValue)")
            
        }
        do {
            repeat try checkEquality(each lhs.value, each rhs.value)
            return true
        } catch {
            return false
        }
    }
    
    public func contains<T>(
        where value: T
    ) -> Bool where T: Equatable {
        array.contains(where: { $0 as? T == value })
    }
}


