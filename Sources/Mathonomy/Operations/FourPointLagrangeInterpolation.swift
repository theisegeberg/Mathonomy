
import Foundation
import CoreGraphics

public extension Double {
    static func fourPointLagrangeInterpolation(a:CGPoint,b:CGPoint,c:CGPoint,d:CGPoint) -> (Double) -> Double {
        func lagrangeTerm(pMain:CGPoint,p1:CGPoint,p2:CGPoint,p3:CGPoint) -> (Double) -> Double {
            func helper(x:Double,p1:CGPoint, p2:CGPoint) -> Double {
                (x - p2.x) / (p1.x - p2.x)
            }
            return { x in
                pMain.y * helper(x: x, p1: pMain, p2: p1) * helper(x: x, p1: pMain, p2: p2) * helper(x: x, p1: pMain, p2: p3)
            }
        }
        return { x in
            let a1 = lagrangeTerm(pMain: a, p1: b, p2: c, p3: d)
            let b1 = lagrangeTerm(pMain: b, p1: a, p2: c, p3: d)
            let c1 = lagrangeTerm(pMain: c, p1: b, p2: a, p3: d)
            let d1 = lagrangeTerm(pMain: d, p1: b, p2: c, p3: a)
            return a1(x) + b1(x) + c1(x) + d1(x)
        }
    }
    
    static func threePointLagrangeInterpolation(a:CGPoint,b:CGPoint,c:CGPoint) -> (Double) -> Double {
        func lagrangeTerm(pMain:CGPoint,p1:CGPoint,p2:CGPoint) -> (Double) -> Double {
            func helper(x:Double,p1:CGPoint, p2:CGPoint) -> Double {
                (x - p2.x) / (p1.x - p2.x)
            }
            return { x in
                pMain.y * helper(x: x, p1: pMain, p2: p1) * helper(x: x, p1: pMain, p2: p2)
            }
        }
        return { x in
            let a1 = lagrangeTerm(pMain: a, p1: b, p2: c)
            let b1 = lagrangeTerm(pMain: b, p1: a, p2: c)
            let c1 = lagrangeTerm(pMain: c, p1: b, p2: a)
            return a1(x) + b1(x) + c1(x)
        }
    }
}



