//
//  Extensions to Basic Types.swift
//  S1 PS4
//
//  Created by George Tait on 13/03/2021.
//

import Foundation



extension Double: AdaptiveSteppable {
    
    
    public func checkEquivalenceUnderRelativeTolerance(_ other: Double, relativeTol: Double) -> Bool {
        
        
        let magdifference = (self - other).magnitude
        
        
        let abs_tol = relativeTol * self.magnitude
        
        
        return magdifference < abs_tol
        
        
    }
}
