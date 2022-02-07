//
//  Protocols.swift
//  S1 All Code
//
//  Created by George Tait on 15/02/2021.
//

import Foundation




public protocol AdaptiveSteppable: Integrable, EquatableUnderRelativeTolerance {
    
    
}



public protocol EquatableUnderRelativeTolerance {
    
    
    func  checkEquivalenceUnderRelativeTolerance (_ other: Self, relativeTol: Double) -> Bool
    
    
}





public protocol Integrable: Addable, Multipliable {
    
}





public protocol Addable {
    
    static func + (left: Self, right: Self) -> Self
}






public protocol Multipliable {
    
    static func * (left: Self, right: Double)-> Self
    
    static func * (left: Double, right: Self) -> Self
}





public protocol Magnitudable {
    
    func magnitude() -> Double
}






public protocol Subtractable: Addable {
    
    static func - (left: Self, right: Self)-> Self
    
}




public protocol physicalSystemDataable {
    
    
    func getStateAtIteration(iteration: Int) -> DoubleVector
    
    
    func getCoordinateAtAllIterations(coordinateIndex: Int) -> [Double]
    
    
    mutating func storeSystemDataAtIteration(state: DoubleVector)
    
    
}



public protocol simulatableSystem {
    
    func simulateSystem<T: physicalSystemDataable>(iterations: Int) -> T
    
}
