//
//  DoubleVector.swift
//  S1 All Code
//
//  Created by George Tait on 15/02/2021.
//

import Foundation


public struct DoubleVector {
    
    
    
    public var elements: [Double]
    
    public init(elements elementsin: [Double]){
        elements = elementsin
    }
    
    
    
    public func plus(_ other: DoubleVector) -> DoubleVector {
        
        var temp = [Double](repeating: 0.0, count: elements.count)
        
        for i in 0..<elements.count {
            
            temp[i] = elements[i] + other.elements[i]
        }
        
        return DoubleVector(elements: temp)
    }
    
    
    
    
    
    
    
    public func scale(_ other: Double) -> DoubleVector {
        var temp1 = [Double](repeating: 0.0, count: elements.count)
        for i in 0...elements.count - 1 {
            temp1[i] = elements[i] * other
        }
        return DoubleVector(elements: temp1)
    }
    
    public func elementWiseMAgnitude() -> DoubleVector {
        
       var magnitudeVector = DoubleVector(elements: [Double](repeating: 0.0, count: elements.count))
        
        
        for i in 0..<elements.count {
            
            magnitudeVector.elements[i] = elements[i].magnitude
            
            
        }
        
        return magnitudeVector
    }
    

    
    
    
    public func dot (_ other: DoubleVector) -> Double {
        
        var temp = 0.0
        
        for i in 0..<elements.count {
            
            
            temp += (elements[i] * other.elements[i])
        }
        
        return temp
    }
    
    
    
    
    
    
}





extension DoubleVector: Integrable {
    
    
    
    public static func + (lhs: DoubleVector, rhs: DoubleVector) -> DoubleVector {
        
        return lhs.plus(rhs)
    }
    
    
    
    
    public static func * (lhs: DoubleVector, rhs: Double) -> DoubleVector {
        
        return lhs.scale(rhs)
    }
    
    
    
    public static func * (lhs: Double, rhs: DoubleVector) -> DoubleVector {
        
        return rhs.scale(lhs)
    }
}






extension DoubleVector: Subtractable {
    
    public static func - (lhs: DoubleVector, rhs: DoubleVector) -> DoubleVector {
        
        return lhs.plus(-1.0 * rhs)
    }
}




extension DoubleVector: Magnitudable {
    
    
    public func magnitude () -> Double {
        
        var mag_squared = 0.0
        
        for i in 0..<elements.count {
            
            
            mag_squared += elements[i] * elements[i]
        }
        
        
        let mag = sqrt(mag_squared)
        
        return mag
    }
}





extension DoubleVector: AdaptiveSteppable {
   
    
    public func checkEquivalenceUnderRelativeTolerance (_ other: DoubleVector, relativeTol: Double) -> Bool {
        
        
        
        let differenceVector = self - other
        
        
        let abs_differencevector = differenceVector.elementWiseMAgnitude()
        
        
        
        let abs_tol = relativeTol * elements.min()!
        
        
        let elementOfMaxDifference = abs_differencevector.elements.max()!
        
        
        
       return elementOfMaxDifference < abs_tol
        
        
    
    
    }
    
}
