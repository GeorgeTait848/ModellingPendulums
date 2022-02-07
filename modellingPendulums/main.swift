//
//  main.swift
//  modellingPendulums
//
//  Created by George Tait on 04/02/2022.
//

import Foundation

public var g = 9.81

var springPendulum_model = SpringPendulum(stiffness: 18.0, theta: Double.pi / 3.0, theta_dot: 0.5, mass: 0.2, length: 0.3, extensionn: 0.0, extension_dot: -1.0)

//let springPendModelSimulation = springPendulum_model.simulateSystem(timeOfSimulation: 10, relativeTol: 0.0001)
//
//
//let extensionData = springPendModelSimulation.getCoordinateAtAllIterations(coordinateIndex: 0)
//
//for i in 0..<extensionData.count {
//
//    print(extensionData[i])
//}


var Double_Pendulum_model = DoublePendulum(length_1: 0.1, mass_1: 0.2, theta1: Double.pi / 3, momentum_theta1: 0.0, length_2: 0.4, mass_2: 0.4, theta2: 5.0 * Double.pi / 6, momentum_theta2: 0.0)

//let doublePendSimulation = Double_Pendulum_model.simulateSystem(timeOfSimulation: 10, relativeTol: 0.0001)
//
//let theta1Data = doublePendSimulation.getCoordinateAtAllIterations(coordinateIndex: 0)
//
//for dataPoint in theta1Data {
//
//    print(dataPoint)
//}

var model_duffing_oscillator = DuffingOscillator(x: 0.05, x_dot:0.0, alpha: 1, beta: 5, gamma: 0.02, delta: 0.02, omega: 0.5)


//let duffingOscillatorSimulation = model_duffing_oscillator.simulateSystem(timeOfSimulation: 25, relativeTol: 0.0001)
//
//
//let xData = duffingOscillatorSimulation.getCoordinateAtAllIterations(coordinateIndex: 0)
//
//for i in 0..<xData.count {
//
//
//    print(xData[i])
//}
