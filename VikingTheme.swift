import SwiftUI

struct VikingTheme {
    // MARK: - Colors
    struct Colors {
        static let darkWood = Color(hex: "2C1810")  // Dark brown background
        static let lightWood = Color(hex: "B08968") // Light brown for buttons
        static let gold = Color(hex: "DAA520")      // Soft gold for accents
        static let deepRed = Color(hex: "8B0000")   // Deep red for active states
        static let parchment = Color(hex: "F5E6D3") // Warm cream for text fields
        static let textDark = Color(hex: "2C1810")  // Dark text on light backgrounds
    }
    
    // MARK: - Text Styles
    struct TextStyle {
        static let titleFont = Font.custom("Papyrus", size: 28).bold()
        static let subtitleFont = Font.custom("Papyrus", size: 16)
        static let bodyFont = Font.custom("Papyrus", size: 14)
        static let buttonFont = Font.custom("Papyrus", size: 16).bold()
    }
    
    // MARK: - Button Style
    struct VikingButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(TextStyle.buttonFont)
                .foregroundColor(configuration.isPressed ? Colors.parchment : Colors.textDark)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Group {
                        if configuration.isPressed {
                            Colors.deepRed
                        } else {
                            Colors.lightWood
                        }
                    }
                )
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
        }
    }
    
    // MARK: - Text Field Style
    struct VikingTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .font(TextStyle.bodyFont)
                .padding()
                .background(Colors.parchment)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        }
    }
    
    // MARK: - Navigation Bar Style
    static func configureNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Colors.darkWood)
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Papyrus", size: 20)!,
            .foregroundColor: UIColor(Colors.gold)
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - Color Extension for Hex Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Preview Helpers
struct ThemePreviewView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Mjöðr Calculator")
                        .font(VikingTheme.TextStyle.titleFont)
                        .foregroundColor(VikingTheme.Colors.gold)
                    
                    Text("Viking Mead Making Assistant")
                        .font(VikingTheme.TextStyle.subtitleFont)
                        .foregroundColor(VikingTheme.Colors.gold)
                    
                    Button("Strength Calculator") {
                        // Action
                    }
                    .buttonStyle(VikingTheme.VikingButtonStyle())
                    
                    TextField("Enter Value", text: .constant(""))
                        .textFieldStyle(VikingTheme.VikingTextFieldStyle())
                        .padding(.horizontal)
                }
                .padding()
            }
            .background(VikingTheme.Colors.darkWood)
            .navigationTitle("Theme Preview")
        }
    }
}

#Preview {
    ThemePreviewView()
}
