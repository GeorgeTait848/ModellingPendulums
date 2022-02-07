//
//  SimulationDataContainer.swift
//  modellingPendulums
//
//  Created by George Tait on 05/02/2022.
//

import Foundation

public struct SimulationDataContainer: physicalSystemDataable {
    
    public var data: [DoubleVector]
    
    
    
    public func getStateAtIteration(iteration: Int) -> DoubleVector {
        
        
        return data[iteration]
        
        
    }
    
    
    
    public func getCoordinateAtAllIterations(coordinateIndex: Int) -> [Double] {
        
       var coordinateValues = [Double](repeating: 0.0, count: data.count)
        
        for i in 0..<coordinateValues.count {
            
                        coordinateValues[i] = data[i].elements[coordinateIndex]
            
        }
        
        return coordinateValues
    }
    
    

    public mutating func storeSystemDataAtIteration(iteration: Int, state:DoubleVector) {
        
        
        data[iteration] = state
        
        
    }
    
    
    
    
}



