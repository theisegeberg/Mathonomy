
import CoreGraphics

public extension CGPoint {
    /// Normalises a CGPoint in a CGSize
    /// - Parameter size: The space for normalization
    /// - Returns: A normalised CGPoint
    func normalize(in size:CGSize) -> Self {
        CGPoint(x: self.x / size.width, y: self.y / size.height)
    }
    
    var invertY:CGPoint {
        CGPoint(x: x, y: y.inverted)
    }
    
    static let one:Self = .init(x: 1, y: 1)
}

public extension CGSize {
    /// Just a size of 1 by 1
    static let one:Self = .init(width: 1, height: 1)
}

public extension CGRect {
    /// Just a 1 by 1 rect
    static let normal:Self = .init(origin: .zero, size: .one)
}
