import SwiftUI

struct StrengthCalculatorView: View {
    @StateObject private var viewModel = StrengthCalculatorViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Input Section
                GroupBox(
                    label: Text("Sacred Measurements")
                        .font(VikingTheme.TextStyle.subtitleFont)
                        .foregroundColor(VikingTheme.Colors.gold)
                ) {
                    VStack(spacing: 16) {
                        // Original Gravity
                        InputField(
                            label: "Original Gravity:",
                            placeholder: "1.060",
                            text: $viewModel.originalGravity
                        )
                        
                        // OG Temperature
                        InputField(
                            label: "OG Temperature (°F):",
                            placeholder: "75",
                            text: $viewModel.originalTemp
                        )
                        
                        // Final Gravity
                        InputField(
                            label: "Final Gravity:",
                            placeholder: "1.012",
                            text: $viewModel.finalGravity
                        )
                        
                        // FG Temperature
                        InputField(
                            label: "FG Temperature (°F):",
                            placeholder: "68",
                            text: $viewModel.finalTemp
                        )
                    }
                    .padding()
                }
                .groupBoxStyle(VikingGroupBoxStyle())
                
                // Calculate Button
                Button("Calculate Strength") {
                    withAnimation {
                        viewModel.calculate()
                    }
                }
                .buttonStyle(VikingTheme.VikingButtonStyle())
                
                // Results Section
                if !viewModel.standardABV.isEmpty {
                    GroupBox(
                        label: Text("Wisdom of Odin")
                            .font(VikingTheme.TextStyle.subtitleFont)
                            .foregroundColor(VikingTheme.Colors.gold)
                    ) {
                        VStack(alignment: .leading, spacing: 12) {
                            ResultRow(label: "Corrected OG:", value: viewModel.correctedOG)
                            ResultRow(label: "Corrected FG:", value: viewModel.correctedFG)
                            Divider().background(VikingTheme.Colors.gold)
                            ResultRow(label: "Standard ABV:", value: viewModel.standardABV)
                            ResultRow(label: "Advanced ABV:", value: viewModel.advancedABV)
                            Divider().background(VikingTheme.Colors.gold)
                            ResultRow(label: "OG in °Plato:", value: viewModel.ogPlato)
                            ResultRow(label: "FG in °Plato:", value: viewModel.fgPlato)
                        }
                        .padding()
                    }
                    .groupBoxStyle(VikingGroupBoxStyle())
                }
            }
            .padding()
        }
        .background(VikingTheme.Colors.darkWood.ignoresSafeArea())
        .alert("Invalid Input", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }
        .navigationTitle("Strength of Mjöðr")
    }
}

// MARK: - Supporting Views
struct InputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.gold)
            TextField(placeholder, text: $text)
                .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                .keyboardType(.decimalPad)
        }
    }
}

struct ResultRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.gold)
            Spacer()
            Text(value)
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.parchment)
        }
    }
}

struct VikingGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.label
            configuration.content
        }
        .padding()
        .background(VikingTheme.Colors.darkWood.opacity(0.7))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(VikingTheme.Colors.gold.opacity(0.3), lineWidth: 2)
        )
    }
}

#Preview {
    NavigationView {
        StrengthCalculatorView()
    }
}
