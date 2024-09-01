import Foundation

public enum AttractionMath {
    
    static func gaussianFalloff(x: Double, sigma: Double) -> Double {
        exp(-(x * x) / (2 * sigma * sigma))
    }
    
    static func distanceGaussian(value:Double, maxDistance:Double, sigma:Double) -> (Double) -> Double {
        {
            1 - gaussianFalloff(x: min(max(abs($0 - value) / maxDistance, 0), 1), sigma: sigma)
        }
    }
    
    static func linear() -> (Double) -> Double {
        {
            $0
        }
    }
    
    static func value(_ x:Double) -> (Double) -> Double {
        { _ in
            x
        }
    }
    
    static func dragging(_ x:Double) -> (Double) -> Double {
        {
            $0 + x
        }
    }
    
    static func mixer(
        a:@escaping (Double) -> Double,
        b:@escaping (Double) -> Double,
        mix:@escaping (Double) -> Double) -> (Double) -> Double {
            return { x in
                let ax = a(x)
                let bx = b(x)
                let mixx = mix(x)
                return (ax * (1 - mixx)) + (bx * mixx)
            }
        }
    
    public static func attractor(center:Double, maxDistance:Double, sigma:Double) -> (Double) -> Double {
        mixer(
            a: value(center),
            b: linear(),
            mix: distanceGaussian(value: center, maxDistance: maxDistance, sigma: sigma))
    }
    
    public static func attractor(drag:Double, center:Double, maxDistance:Double, sigma:Double) -> (Double) -> Double {
        mixer(
            a: dragging(drag),
            b: linear(),
            mix: distanceGaussian(value: center, maxDistance: maxDistance, sigma: sigma))
    }
}

