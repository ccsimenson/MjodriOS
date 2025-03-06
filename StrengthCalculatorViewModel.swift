import Foundation
import SwiftUI

class StrengthCalculatorViewModel: ObservableObject {
    @Published var originalGravity: String = "1.060"
    @Published var originalTemp: String = "75"
    @Published var finalGravity: String = "1.012"
    @Published var finalTemp: String = "68"
    
    @Published var correctedOG: String = ""
    @Published var correctedFG: String = ""
    @Published var standardABV: String = ""
    @Published var advancedABV: String = ""
    @Published var ogPlato: String = ""
    @Published var fgPlato: String = ""
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    func calculate() {
        // Convert input strings to doubles
        guard let og = Double(originalGravity),
              let ogTemp = Double(originalTemp),
              let fg = Double(finalGravity),
              let fgTemp = Double(finalTemp) else {
            showError = true
            errorMessage = "Please enter valid numbers"
            return
        }
        
        // Validate gravity ranges
        guard (1.000...1.200).contains(og) && (1.000...1.200).contains(fg) else {
            showError = true
            errorMessage = "Gravity values should be between 1.000 and 1.200"
            return
        }
        
        // Calculate temperature corrections
        let ogCorrected = MeadCalculations.correctGravityForTemperature(gravity: og, measuredTemp: ogTemp)
        let fgCorrected = MeadCalculations.correctGravityForTemperature(gravity: fg, measuredTemp: fgTemp)
        
        // Calculate ABV using both methods
        let abvStandard = MeadCalculations.calculateABVStandard(originalGravity: ogCorrected, finalGravity: fgCorrected)
        let abvAdvanced = MeadCalculations.calculateABVAdvanced(originalGravity: ogCorrected, finalGravity: fgCorrected)
        
        // Convert to Plato
        let ogPlatoValue = MeadCalculations.gravityToPlato(gravity: ogCorrected)
        let fgPlatoValue = MeadCalculations.gravityToPlato(gravity: fgCorrected)
        
        // Update UI
        correctedOG = String(format: "%.3f", ogCorrected)
        correctedFG = String(format: "%.3f", fgCorrected)
        standardABV = String(format: "%.2f%%", abvStandard)
        advancedABV = String(format: "%.2f%%", abvAdvanced)
        ogPlato = String(format: "%.2f°P", ogPlatoValue)
        fgPlato = String(format: "%.2f°P", fgPlatoValue)
    }
    
    func clearResults() {
        correctedOG = ""
        correctedFG = ""
        standardABV = ""
        advancedABV = ""
        ogPlato = ""
        fgPlato = ""
    }
}
