import XCTest
@testable import MjodriOS

final class MeadCalculationsTests: XCTestCase {
    func testGravityTemperatureCorrection() {
        // Test standard temperature correction
        let gravity = 1.050
        let measuredTemp = 70.0
        let expected = 1.051 // Calculated manually
        let result = MeadCalculations.correctGravityForTemperature(gravity: gravity, measuredTemp: measuredTemp)
        XCTAssertEqual(result, expected, accuracy: 0.001)
        
        // Test no correction needed
        let resultNoCorrection = MeadCalculations.correctGravityForTemperature(gravity: gravity, measuredTemp: 60.0)
        XCTAssertEqual(resultNoCorrection, gravity, accuracy: 0.001)
    }
    
    func testStandardABVCalculation() {
        let og = 1.055
        let fg = 1.015
        let expected = 5.25 // (1.055 - 1.015) * 131.25
        let result = MeadCalculations.calculateABVStandard(originalGravity: og, finalGravity: fg)
        XCTAssertEqual(result, expected, accuracy: 0.01)
    }
    
    func testAdvancedABVCalculation() {
        let og = 1.120
        let fg = 1.030
        let result = MeadCalculations.calculateABVAdvanced(originalGravity: og, finalGravity: fg)
        XCTAssertGreaterThan(result, 0)
        XCTAssertLessThan(result, 30) // Reasonable range for mead
    }
    
    func testGravityToPlato() {
        let gravity = 1.040
        let expected = 10.0 // Approximate value
        let result = MeadCalculations.gravityToPlato(gravity: gravity)
        XCTAssertEqual(result, expected, accuracy: 0.5)
    }
}
