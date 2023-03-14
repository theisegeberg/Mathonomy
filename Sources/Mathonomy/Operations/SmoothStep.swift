
import Foundation

public extension Double {
    static func smoothStep() -> (Double) -> Double {
        { x in
            x * x * (3 - 2 * x);
        }
    }
    
    static func smootherStep() -> (Double) -> Double {
        { x in
            x * x * x * (x * (x * 6 - 15) + 10)
        }
    }
    
    static func smoothSmootherStep(transition:Double) -> (Double) -> Double {
        { x in
            (smoothStep()(x) * transition) + (smootherStep()(x) * (transition.inverted))
        }
    }
    
    static func pascalTriangle(a:Double, b:Int) -> Double {
        var result:Double = 1;
        for i in 0..<b {
            result *= (a - Double(i)) / (Double(i) + 1);
        }
        return result;
    }
    
    static func generalSmoothstep(order:Int) -> (Double) -> Double {
        return { x in
            (0..<order).map { n -> Double in
                pascalTriangle(a: Double(-order - 1), b: n) * pascalTriangle(a: Double(2 * order + 1), b: order - n) * Double.pow(x, Double(order + n + 1));
            }.reduce(0, +)
        }
        
    }
    
    
}
