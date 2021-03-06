//
//  DuffingOscillator.swift
//  modellingPendulums
//
//  Created by George Tait on 06/02/2022.
//



import Foundation

struct DuffingOscillator {
    
    var x: Double
    var x_dot: Double
    
    
    var alpha: Double
    var beta: Double
    var gamma: Double
    var delta: Double
    

    var omega: Double
    
    mutating func simulateSystem(timeOfSimulation: Double, relativeTol: Double) -> SimulationDataContainer {
        
        var currentStep = 0.01
        
     
        
        let initialState = getCurrentState()
        
        //this is so after the simulation, we can reassign the properties of the initial system back to itself so that we could repeat the simulation if we wanted.
        
        
        var outputData = SimulationDataContainer(data: [])
        
        
        outputData.storeSystemDataAtIteration(state: initialState)
        
        var currentTime = 0.0
        
        
        while currentTime < timeOfSimulation {
            
            let currentState = getCurrentState()
            
            
             currentStep = adaptStep(f: getCurrentDerivatives(currentState:currentTime:), y: currentState, x: currentTime, h: currentStep, relativeTol: relativeTol)
            
            
            updateCurrentState(currentState: currentState, currentTime: currentTime, step: currentStep)
            
            outputData.storeSystemDataAtIteration(state: currentState)
            
            currentTime += currentStep
        
            
        }
        
        reassignProperties(currentState: initialState)
        
        
        return outputData
                
        
    }
    
    
    
    mutating func updateCurrentState(currentState: DoubleVector, currentTime: Double, step: Double) {
          
        let  newState = rungeKuttaFourthOrder(f: getCurrentDerivatives(currentState: currentTime:), y: currentState, x: currentTime, h: step)
          
          
          reassignProperties(currentState: newState)
          
      }
    
    
    
    func getCurrentDerivatives(currentState: DoubleVector, currentTime: Double) -> DoubleVector {
        
        return DoubleVector(elements: [d_dt_x(currentState: currentState, placeHolder: 0), d2_dt2_x(currentState: currentState, t: currentTime)])
        
        
        
    }
    
    
    
    mutating func reassignProperties(currentState: DoubleVector) {
        
        
        x = currentState.elements[0]
        
        x_dot = currentState.elements[1]
        
    }
    
    
    
    
    func getCurrentState() -> DoubleVector {
        
        return DoubleVector(elements: [x, x_dot])
        
    }
    
    
    
    
    func d_dt_x (currentState: DoubleVector, placeHolder: Double) -> Double {
        
        return currentState.elements[1]
    }
    
    
    
    
    func d2_dt2_x (currentState: DoubleVector, t : Double) -> Double {
        
        let returnvalue = gamma * cos(omega * t) - (delta * currentState.elements[1] + alpha * currentState.elements[0] + beta * currentState.elements[0] * currentState.elements[0] * currentState.elements[0])
        
//        let returnvalue = gamma * cos(omega * t ) - ( (delta * outputs.elements[1]) + (alpha * outputs.elements[0]) + (beta  * outputs.elements[0] * outputs.elements[0] * outputs.elements[0]))
        
        return returnvalue
        
    }
    
    
   
    
    
    
//    func solve_eqs_of_motion_Euler (step: Double, loopcount: Int) -> DoubleVector {
//
//        var outputs = DoubleVector(elements: [x, x_dot])
//
//
//
//        func d_dt_x (_ : Double) -> Double {
//
//
//            let returnvalue = outputs.elements[1]
//
//            return returnvalue
//        }
//
//
//
//
//
//        func d2_dt2_x (t : Double) -> Double {
//
//            let returnvalue = gamma * cos( omega * t ) - ( (delta * outputs.elements[1]) + (alpha * outputs.elements[0]) + (beta  * outputs.elements[0] * outputs.elements[0] * outputs.elements[0]))
//
//            return returnvalue
//
//        }
//
//
//
//        var t_vec = DoubleVector(elements: [0.0, 0.0])
//
//        let steps_vec = DoubleVector(elements: [Double](repeating: step, count: 2))
//
//
//        let Differential_Eqs = functionsVector(funcs_elements: [d_dt_x(_:), d2_dt2_x(t:)])
//
//
//        for _ in 1...loopcount {
//
//            t_vec = t_vec.plus(steps_vec)
//
//            outputs = EulersMethod_Vectors(Differential_Eqs: Differential_Eqs, initialinputs: t_vec, initialoutputs: outputs, step: step)
//
//            outputs.elements[0]
//            outputs.elements[1]
//
//
//
//
//
//
//
//        }
//
//
//        return outputs
//    }
//
}



