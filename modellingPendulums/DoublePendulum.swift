//
//  DoublePendulum.swift
//  modellingPendulums
//
//  Created by George Tait on 05/02/2022.
//

import Foundation

import Foundation

public struct DoublePendulum {
    
  public var length_1: Double
  public var mass_1: Double
  public var theta1: Double
  public var momentum_theta1: Double
    
    
  public var length_2: Double
  public var mass_2: Double
  public var theta2: Double
  public var momentum_theta2: Double
    
    //derivatives come from getting the Hamiltonian of the system and determining hamiltons equations of motion
    
    
    
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
    
    
    mutating func reassignProperties(currentState: DoubleVector) {
        
        theta1 = currentState.elements[0]
        theta2 = currentState.elements[2]
        
        momentum_theta1 = currentState.elements[1]
        momentum_theta2 = currentState.elements[3]
        
    }
    
    func getCurrentState() -> DoubleVector {
        
        
        return DoubleVector(elements: [theta1, momentum_theta1, theta2, momentum_theta2])
        
        
    }
    
    
    
    func getCurrentDerivatives(currentState: DoubleVector, placeholder: Double) -> DoubleVector {
        
        
        let theta1Dot = getTheta_1_derivative(currentState: currentState)
        
        let theta2Dot = getTheta_2_derivative(currentState: currentState)
        
        
        let currentMomentaDerivatives = getMomentumTheta_Momenta_1_2(currentState: currentState)
        
        
        return DoubleVector(elements: [theta1Dot, currentMomentaDerivatives[0], theta2Dot, currentMomentaDerivatives[1]])
        
    }
    
    
    func getTheta_1_derivative(currentState: DoubleVector) -> Double {
        
        
        
        let psi = currentState.elements[0] - currentState.elements[2]
        
        let numerator = length_2*momentum_theta1 - length_1*momentum_theta2*cos(psi)
        
        let denominator = length_1*length_1*length_2*(mass_1 + mass_2*sin(psi)*sin(psi))
        
        return numerator/denominator
        
    }
    
    func getTheta_2_derivative(currentState: DoubleVector) -> Double {
        
        let psi = currentState.elements[0] - currentState.elements[2]
        
        let numerator = (mass_1 + mass_2)*length_1*momentum_theta2 - mass_2*length_1*momentum_theta1*cos(psi)
        
        let denominator = mass_2*length_1*length_2*length_2*(mass_1 + mass_2*sin(psi)*sin(psi))
        
        return numerator/denominator
        
    }
    
    
    
    func getMomentumTheta_Momenta_1_2(currentState: DoubleVector) -> [Double] {
        
        //written this way as to not have to redefine constants a,b
        
        var output = [0.0, 0.0]
        
        let psi = currentState.elements[0] - currentState.elements[2]
        
        let a = momentum_theta1*momentum_theta2*sin(psi)/(length_1*length_2*(mass_1 + mass_2 * sin(psi)*sin(psi)))

        let b_num = mass_2*length_2*length_2*momentum_theta1*momentum_theta1 + (mass_1 + mass_2) * length_1 * length_1 * momentum_theta2 * momentum_theta2 - 2*mass_2*length_1*length_2 * momentum_theta1 * momentum_theta2 * cos(psi)
        
        let b_denom = 2 * length_1*length_1 * length_2 * length_2 * (mass_1 + mass_2 * sin(psi)*sin(psi))
        
        let b = b_num/b_denom
        
        output[0] =  b*sin(2*psi) - a - (mass_1 + mass_2)*g*length_1*sin(theta1)
        
        output[1] = a - b*sin(2*psi - mass_2*length_2*g*sin(theta2))
        
        return output
        
        
    }
   

    
    


}


