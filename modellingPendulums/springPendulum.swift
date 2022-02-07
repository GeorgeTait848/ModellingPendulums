//
//  springPendulum.swift
//  modellingPendulums
//
//  Created by George Tait on 04/02/2022.
//

import Foundation



public struct SpringPendulum {
    
    public let stiffness: Double
    public var theta: Double // defined as the angle between the spring and the negative y axis.
    public var theta_dot: Double
    public let mass: Double
    public let length: Double
    public var extensionn: Double
    public var extension_dot: Double
    
    
    
    //All second derivatives come from solving the euler lagrange equation for this system.
    
    
    
    mutating func simulateSystem(numberOfIterations: Int, relativeTol: Double) -> SimulationDataContainer {
        
        var currentStep = 0.01
        
     
        
        let initialState = getCurrentState()
        
        //this is so after the simulation, we can reassign the properties of the initial system back to itself so that we could repeat the simulation if we wanted.
        
        
        var outputData = SimulationDataContainer(data: [DoubleVector](repeating: DoubleVector(elements: [Double](repeating: 0.0, count: 4)), count: numberOfIterations))
        
        
        outputData.storeSystemDataAtIteration(iteration: 0, state: initialState)
        
        
        for i in 1..<outputData.data.count {
            
            let currentState = getCurrentState()
            
            
             currentStep = adaptStep(f: getCurrentDerivatives(currentState:placeholder:), y: currentState, x: 0, h: currentStep, relativeTol: relativeTol)
            
             updateCurrentState(currentState: currentState, step: currentStep)
            
            outputData.storeSystemDataAtIteration(iteration: i, state: currentState)
            
        
            
        }
        
        reassignProperties(currentState: initialState)
        
        
        return outputData
                
        
    }
    
    
    
    
  mutating func updateCurrentState(currentState: DoubleVector, step: Double) {
        
      let  newState = rungeKuttaFourthOrder(f: getCurrentDerivatives(currentState: placeholder:), y: currentState, x: 0, h: step)
        
        
        reassignProperties(currentState: newState)
        
    }
    
    
    
    func getCurrentDerivatives(currentState: DoubleVector, placeholder: Double) -> DoubleVector {
        
        //placeholder is used to be able to use with RK method
        
        
        let currentExtensionDot = currentState.elements[1]
        
        let currentExtensionDDot = getExtensionSecondTimeDerivative()
        
        let currentThetaDot = currentState.elements[2]
        
        let currentThetaDDot = getThetaSecondTimederivative()
        
        
        return DoubleVector(elements: [currentExtensionDot, currentExtensionDDot, currentThetaDot, currentThetaDDot])
        
        
    }
    
  
    
    func getExtensionTimeDerivative() -> Double {
        
        return extension_dot
    }
    
    
    
    func getExtensionSecondTimeDerivative() -> Double {
        
        
        return ((length + extensionn) * theta_dot * theta_dot) - ((stiffness * extensionn) / mass) + (g * cos(theta))
        

    }

    
    
    
    func getThetaTimeDerivative() -> Double {
        
        
        return theta_dot
    }
    
    
    
    
    func getThetaSecondTimederivative() -> Double {
        
        
        return    ((-2.0 / (length + extensionn)) * extension_dot * theta_dot) - ((g * sin(theta)) / (length + extensionn))
    }
    

    
    
    
    mutating func reassignProperties(currentState: DoubleVector) {
        
        
        extensionn = currentState.elements[0]
        
        extension_dot = currentState.elements[1]
        
        theta = currentState.elements[2]
        
        theta_dot = currentState.elements[3]
    }
    
    
    
    
   public func getCurrentState() -> DoubleVector {
        
        return DoubleVector(elements: [extensionn, extension_dot, theta, theta_dot])
        
    }

    
}







    

