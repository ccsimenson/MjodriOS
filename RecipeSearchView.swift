import SwiftUI
import SafariServices

struct RecipeSearchView: View {
    @State private var selectedMeadType: MeadType?
    @State private var showSafari = false
    @State private var searchURL: URL?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                Text("Ancient Recipes")
                    .font(VikingTheme.TextStyle.titleFont)
                    .foregroundColor(VikingTheme.Colors.gold)
                
                Text("Choose Your Mead Style")
                    .font(VikingTheme.TextStyle.subtitleFont)
                    .foregroundColor(VikingTheme.Colors.gold)
                
                // Mead Types Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(MeadType.types) { meadType in
                        MeadTypeCard(
                            meadType: meadType,
                            isSelected: selectedMeadType?.id == meadType.id,
                            action: {
                                withAnimation(.spring()) {
                                    selectedMeadType = meadType
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal)
                
                // Search Button
                if let selected = selectedMeadType {
                    Button("Search Ancient Knowledge") {
                        let query = selected.searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                        searchURL = URL(string: "https://www.youtube.com/results?search_query=\(query)")
                        showSafari = true
                    }
                    .buttonStyle(VikingTheme.VikingButtonStyle())
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .background(VikingTheme.Colors.darkWood.ignoresSafeArea())
        .sheet(isPresented: $showSafari) {
            if let url = searchURL {
                SafariView(url: url)
            }
        }
        .navigationTitle("Ancient Recipes")
    }
}

struct MeadTypeCard: View {
    let meadType: MeadType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text(meadType.name)
                    .font(VikingTheme.TextStyle.bodyFont.bold())
                    .foregroundColor(isSelected ? VikingTheme.Colors.gold : VikingTheme.Colors.parchment)
                    .multilineTextAlignment(.leading)
                
                Text(meadType.description)
                    .font(VikingTheme.TextStyle.bodyFont)
                    .foregroundColor(isSelected ? VikingTheme.Colors.parchment : VikingTheme.Colors.parchment.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? VikingTheme.Colors.deepRed : VikingTheme.Colors.lightWood)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(VikingTheme.Colors.gold.opacity(isSelected ? 0.8 : 0.3), lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .shadow(color: Color.black.opacity(0.2), radius: isSelected ? 4 : 2)
        .animation(.spring(), value: isSelected)
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

#Preview {
    NavigationView {
        RecipeSearchView()
    }
}
