
import Foundation

public extension BinaryFloatingPoint {
    var bound01:Self {
        if self < 0 {
            return 0
        } else if self > 1 {
            return 1
        }
        return self
    }
    
    var inverted:Self {
        1 - self
    }
    
    var half:Self {
        self / 2
    }

    var x2:Self {
        self * 2
    }
    
    var absolute:Self {
        abs(self)
    }
}
