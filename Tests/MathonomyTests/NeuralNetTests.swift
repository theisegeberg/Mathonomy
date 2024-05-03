
import XCTest
import simd
@testable import Mathonomy

final class NeuralNetTests: XCTestCase {

    func testSimdBasics() {
        let a_f16 = SIMD16<Float>.init(repeating: 1)
        XCTAssertEqual(a_f16.sum(), 16)
        let b_f16 = SIMD16<Float>.init(repeating: 2)
        let c_f16 = SIMD16<Float>.init(repeating: 3)
        let bc_f16 = b_f16 * c_f16
        XCTAssertEqual(bc_f16[0], 6)
        XCTAssertEqual(bc_f16[1], 6)
        XCTAssertEqual(bc_f16.sum(), 2*3*16)
        
        let neurons = [
            
        ]
        
    }
    
}

