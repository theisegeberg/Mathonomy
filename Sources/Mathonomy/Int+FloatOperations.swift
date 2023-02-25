
extension FixedWidthInteger {
    public func divided(by other:Int) -> Double {
        Double(self) / Double(other)
    }
    
    public func multiplied(by other:Double) -> Double {
        other * Double(self)
    }
    
    public static func maxMultiplied(by other:Double) -> Self {
        Self(Self.max.multiplied(by: other.clamped()))
    }
}
