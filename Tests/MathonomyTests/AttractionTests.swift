//
//import XCTest
//import Algorithms
//@testable import Mathonomy
//
//final class AttractionTests: XCTestCase {
//    func testAttraction() {
//        let x = 0.5
//        let plotter = Plotter(samples: 10, inRange: 0...1)
//        plotter.plot().map { double in
//            let attracted = double.attract(towards: x, range: 0...1) { distance in
//                return 1/distance
//            }
//            print(x, double, attracted)
//            return attracted
//
//        }
//        .windows(ofCount: 2)
//        .forEach { arrs in
//            let arr = Array(arrs)
//            guard arr.count == 2 else {
//                return
//            }
//            print(abs(Double(arr[0]) - Double(arr[1])))
//        }
//
//    }
//    
//}
