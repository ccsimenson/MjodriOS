import Foundation

struct MeadCalculations {
    /// Correct specific gravity reading for temperature differences
    static func correctGravityForTemperature(gravity: Double, measuredTemp: Double, calibrationTemp: Double = 60.0) -> Double {
        let correction = (measuredTemp - calibrationTemp) * 0.00000225 * gravity
        return round((gravity + correction) * 1000) / 1000
    }
    
    /// Calculate ABV using the standard formula
    static func calculateABVStandard(originalGravity: Double, finalGravity: Double) -> Double {
        let abv = (originalGravity - finalGravity) * 131.25
        return round(abv * 100) / 100
    }
    
    /// Calculate ABV using a more accurate formula for high-alcohol beverages
    static func calculateABVAdvanced(originalGravity: Double, finalGravity: Double) -> Double {
        let abv = (76.08 * (originalGravity - finalGravity) / (1.775 - originalGravity)) * (finalGravity / 0.794)
        return round(abv * 100) / 100
    }
    
    /// Convert specific gravity to degrees Plato
    static func gravityToPlato(gravity: Double) -> Double {
        let plato = (-1 * 616.868) + (1111.14 * gravity) - (630.272 * pow(gravity, 2)) + (135.997 * pow(gravity, 3))
        return round(plato * 100) / 100
    }
}
