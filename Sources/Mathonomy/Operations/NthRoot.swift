
import Foundation

public extension Double {
    func nthRoot(n:Double) -> Double {
        return self < 0 && (abs(n.truncatingRemainder(dividingBy: 2)) == 1)
        ? -pow(-self, 1/n)
        : pow(self, 1/n)
    }
    
    static func nthRoot(n:Double) -> (Double) -> Double {
        {
            $0.nthRoot(n: n)
        }
    }
}
