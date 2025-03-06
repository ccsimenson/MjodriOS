import SwiftUI

struct RunesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                Text("Runes of Knowledge")
                    .font(VikingTheme.TextStyle.titleFont)
                    .foregroundColor(VikingTheme.Colors.gold)
                
                Text("Ancient wisdom to guide your mead-making journey")
                    .font(VikingTheme.TextStyle.subtitleFont)
                    .foregroundColor(VikingTheme.Colors.gold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Knowledge Sections
                KnowledgeSection(
                    title: "Strength Calculator",
                    rune: "ᚨ",
                    content: [
                        "Enter Original Gravity (OG) and Final Gravity (FG) readings",
                        "Include temperature for accurate corrections",
                        "View both standard and advanced ABV calculations",
                        "See gravity values in both specific gravity and Plato"
                    ]
                )
                
                KnowledgeSection(
                    title: "Ancient Recipes",
                    rune: "ᛗ",
                    content: [
                        "Choose from traditional mead styles",
                        "Learn about different mead varieties",
                        "Find video tutorials and recipes",
                        "Discover ancient brewing techniques"
                    ]
                )
                
                KnowledgeSection(
                    title: "Mead Hall",
                    rune: "ᛒ",
                    content: [
                        "Track multiple batches of mead",
                        "Monitor fermentation progress",
                        "Record temperature and gravity readings",
                        "Keep detailed brewing notes",
                        "Mark batches as completed when done"
                    ]
                )
                
                // Calculations Guide
                GroupBox {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Sacred Formulas")
                            .font(VikingTheme.TextStyle.subtitleFont)
                            .foregroundColor(VikingTheme.Colors.gold)
                        
                        FormulaRow(
                            title: "Standard ABV",
                            formula: "(OG - FG) × 131.25"
                        )
                        
                        FormulaRow(
                            title: "Advanced ABV",
                            formula: "76.08 × (OG - FG) / (1.775 - OG) × (FG / 0.794)"
                        )
                        
                        FormulaRow(
                            title: "Temperature Correction",
                            formula: "Correction = (T₁ - 60°F) × 0.00000225 × Gravity"
                        )
                    }
                    .padding()
                }
                .groupBoxStyle(VikingGroupBoxStyle())
                .padding(.horizontal)
                
                // Tips Section
                GroupBox {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Wisdom of the Elders")
                            .font(VikingTheme.TextStyle.subtitleFont)
                            .foregroundColor(VikingTheme.Colors.gold)
                        
                        TipRow(
                            tip: "Always sanitize your equipment thoroughly",
                            icon: "🧼"
                        )
                        
                        TipRow(
                            tip: "Keep detailed records of each batch",
                            icon: "📝"
                        )
                        
                        TipRow(
                            tip: "Monitor temperature during fermentation",
                            icon: "🌡️"
                        )
                        
                        TipRow(
                            tip: "Be patient - good mead takes time",
                            icon: "⏳"
                        )
                    }
                    .padding()
                }
                .groupBoxStyle(VikingGroupBoxStyle())
                .padding(.horizontal)
            }
            .padding()
        }
        .background(VikingTheme.Colors.darkWood.ignoresSafeArea())
        .navigationTitle("Runes of Knowledge")
    }
}

struct KnowledgeSection: View {
    let title: String
    let rune: String
    let content: [String]
    
    var body: some View {
        GroupBox {
            VStack(spacing: 12) {
                HStack {
                    Text(rune)
                        .font(.system(size: 32))
                        .foregroundColor(VikingTheme.Colors.gold)
                    
                    Text(title)
                        .font(VikingTheme.TextStyle.subtitleFont)
                        .foregroundColor(VikingTheme.Colors.gold)
                }
                
                ForEach(content, id: \.self) { item in
                    HStack(alignment: .top) {
                        Text("•")
                            .foregroundColor(VikingTheme.Colors.gold)
                        Text(item)
                            .font(VikingTheme.TextStyle.bodyFont)
                            .foregroundColor(VikingTheme.Colors.parchment)
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .groupBoxStyle(VikingGroupBoxStyle())
        .padding(.horizontal)
    }
}

struct FormulaRow: View {
    let title: String
    let formula: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.gold)
            
            Text(formula)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(VikingTheme.Colors.parchment)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background(VikingTheme.Colors.darkWood.opacity(0.5))
                .cornerRadius(4)
        }
    }
}

struct TipRow: View {
    let tip: String
    let icon: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(icon)
                .font(.title2)
            
            Text(tip)
                .font(VikingTheme.TextStyle.bodyFont)
                .foregroundColor(VikingTheme.Colors.parchment)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationView {
        RunesView()
    }
}
