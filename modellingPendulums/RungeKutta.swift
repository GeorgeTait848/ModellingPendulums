//
//  RungeKutta.swift
//  S1 All Code
//
//  Created by George Tait on 15/02/2021.
//

import Foundation


public func adaptiveRungeKuttaOverRange <T: AdaptiveSteppable> (f: (T, Double) -> T, y: T, x: Double, h: Double, relativeTol: Double, upperlimit: Double) -> T {
    
    var current_h = h
    
    var current_y = y
    
    var current_x = x
    
    
    while current_x < upperlimit {
        
        current_h = adaptStep(f: f, y: current_y, x: current_x, h: current_h, relativeTol: relativeTol)
        
        current_y = rungeKuttaFourthOrder(f: f, y: current_y, x: current_x, h: current_h)
        
        current_x += current_h
        
        
    }
        
        
        current_h = upperlimit - current_x
    
    
    current_y = rungeKuttaFourthOrder(f: f, y: current_y, x: current_x, h: current_h)
    
    return current_y
    
    
    
}


public func printAdaptiveRungeKuttaOverRange <T: AdaptiveSteppable> (f: (T, Double) -> T, y: T, x: Double, h: Double, relativeTol: Double, upperlimit: Double) {
    
    var current_h = h
    
    var current_y = y
    
    var current_x = x
    
    
    while current_x < upperlimit {
        
        print(current_y)
        
        current_h = adaptStep(f: f, y: current_y, x: current_x, h: current_h, relativeTol: relativeTol)
        
        current_y = rungeKuttaFourthOrder(f: f, y: current_y, x: current_x, h: current_h)
        
        current_x += current_h
        
        
    }
        
        
    current_h = upperlimit - current_x


current_y = rungeKuttaFourthOrder(f: f, y: current_y, x: current_x, h: current_h)

    
    print(current_y)
    
}





public func adaptiveRungeKuttaFourthOrder <T: AdaptiveSteppable> (f: (T, Double) -> T, y: T, x: Double, h: Double, relativeTol: Double) -> T {
    
   
    
    
    let new_h = adaptStep(f: f, y: y, x: x, h: h, relativeTol: relativeTol)
    
    
    
    let new_y = rungeKuttaFourthOrder(f: f, y: y, x: x, h: new_h)
    
    
    return new_y
    
    
    
}



public func adaptStep <T: AdaptiveSteppable> (f: (T, Double) -> T, y: T, x: Double, h: Double, relativeTol: Double) -> Double {
    
    
    let hh = h / 2.0
    
    let dh = h * 2.0
    
    
    let min_h = 0.0005
    

    
    let new_y_h = rungeKuttaFourthOrder(f: f, y: y, x: x, h: h)
    
    
    
    let new_y_hh = rungeKuttaFourthOrder(f: f, y: y, x: x, h: hh)
    
    
    
    let new_y_dh = rungeKuttaFourthOrder(f: f, y: y, x: x, h: dh)
    
    
    if h < min_h {
        
        
        return min_h
        
    }
 
    
  else if new_y_hh.checkEquivalenceUnderRelativeTolerance(new_y_h, relativeTol: relativeTol) == false {
    
        
        
        return adaptStep(f: f, y: y, x: x, h: hh, relativeTol: relativeTol)
    
    
    }
    
    
    else if new_y_h.checkEquivalenceUnderRelativeTolerance(new_y_dh, relativeTol: relativeTol) == false {
        
        
        return h
    }
    
    else {
        
        return adaptStep(f: f, y: y, x: x, h: dh, relativeTol: relativeTol)
    }
    
}








public func rungeKuttaFourthOrder <T: Integrable> (f: (T, Double) -> T, y: T, x: Double, h: Double) -> T {
    
    
    let K_1 = f(y , x)
    
    
    let K_2 = f(y + (h * K_1 * 0.5), x + h/2)
    
    let K_3 = f(y + (h * K_2 * 0.5), x + h/2)
    
    let K_4 = f(y + (h * K_3), x + h)
    
    
    let tot_slope = K_1 + 2*K_2 + 2*K_3 + K_4
    
    
    let total_change = (h/6)*tot_slope
    
    
    let new_y = y + total_change
    
    
    return new_y
    
}



