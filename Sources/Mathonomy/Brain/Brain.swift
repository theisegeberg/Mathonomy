
import Foundation
import simd

public struct Brain {
        
    public typealias PrecisionType = Float
    public typealias Weights = SIMD16<PrecisionType>
    public typealias Result = PrecisionType
    public typealias LayerValues = Weights
    
    public func think(inputs:LayerValues, neuronLayers:[[Neuron]]) -> LayerValues {
        var runningInputs:LayerValues = inputs
        for neuronLayer in neuronLayers {
            let layerResult = think(initialInputs: runningInputs, neurons: neuronLayer)
            runningInputs = layerResult
        }
        return runningInputs
    }
    
    func think(initialInputs:LayerValues, neurons:[Neuron]) -> Weights {
        var runningInputs:LayerValues = initialInputs
        for (count, neuron) in neurons.enumerated() {
            let neuronResult = neuron.think(inputs: runningInputs)
            runningInputs[count] = neuronResult
        }
        return runningInputs
    }
    
    public struct Neuron {
        public enum ActivationFunction {
            case sigmoid
            case tanh
            
            func calculate(_ value:PrecisionType) -> PrecisionType {
                switch self {
                    case .sigmoid: 1 / (1 + exp(-value))
                    case .tanh: PrecisionType.tanh(value)
                }
            }
        }
        
        public let activationFunction:ActivationFunction
        public let weights:Weights
        
        public func mutated(strength:PrecisionType) -> Neuron {
            var newWeights = weights
            for i in weights.indices {
                newWeights[i] =  Float.random(in: -1...1) * strength
            }
            return Neuron(activationFunction: self.activationFunction, weights: self.weights + newWeights)
            
        }
        
        func think(inputs:LayerValues) -> Result {
            let weighted = inputs * weights
            let sum = weighted.sum()
            return activationFunction.calculate(sum)
        }
    }
    
    

}
