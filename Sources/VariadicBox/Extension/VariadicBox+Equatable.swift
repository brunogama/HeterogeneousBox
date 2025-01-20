//
//  VariadicBox+Equatable.swift
//  VariadicBox
//
//  Created by Bruno da Gama Porciuncula on 19/01/25.
//

public extension Equatable where Self: VariadicBox {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.elementsEqual(rhs)
    }
}
