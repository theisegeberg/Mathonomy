
import Foundation

public enum BayerDithering {
    private static let bayer8x8: [[Int]] = [
        [0, 32, 8, 40, 2, 34, 10, 42],
        [48, 16, 56, 24, 50, 18, 58, 26],
        [12, 44, 4, 36, 14, 46, 6, 38],
        [60, 28, 52, 20, 62, 30, 54, 22],
        [3, 35, 11, 43, 1, 33, 9, 41],
        [51, 19, 59, 27, 49, 17, 57, 25],
        [15, 47, 7, 39, 13, 45, 5, 37],
        [63, 31, 55, 23, 61, 29, 53, 21],
    ]
    private static let bayer8x8PreMult = bayer8x8.map {
        $0.map {
            Double($0 + 1) / 64 - 0.5
        }
    }
    
    private static let bayerN: Int = 8
    private static let bayerR: Double = .init(16.bitMaxValue)
    
    public static func bayerValue(forX x: Int, andY y: Int) -> Double {
        precondition(x >= 0)
        precondition(y >= 0)
        precondition(bayerR >= 0)
        precondition(bayerN >= 0)
        return bayer8x8PreMult[y % bayerN][x % bayerN] * bayerR
    }
}
