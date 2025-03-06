import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                VikingTheme.Colors.darkWood
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Title
                    Text("Mjöðr Calculator")
                        .font(VikingTheme.TextStyle.titleFont)
                        .foregroundColor(VikingTheme.Colors.gold)
                    
                    Text("Viking Mead Making Assistant")
                        .font(VikingTheme.TextStyle.subtitleFont)
                        .foregroundColor(VikingTheme.Colors.gold)
                    
                    // Main Navigation Buttons
                    VStack(spacing: 16) {
                        NavigationLink(destination: Text("Strength Calculator")) {
                            Text("Strength Calculator")
                        }
                        .buttonStyle(VikingTheme.VikingButtonStyle())
                        
                        NavigationLink(destination: Text("Ancient Recipes")) {
                            Text("Ancient Recipes")
                        }
                        .buttonStyle(VikingTheme.VikingButtonStyle())
                        
                        NavigationLink(destination: Text("Mead Hall")) {
                            Text("Mead Hall")
                        }
                        .buttonStyle(VikingTheme.VikingButtonStyle())
                        
                        NavigationLink(destination: Text("Runes of Knowledge")) {
                            Text("Runes of Knowledge")
                        }
                        .buttonStyle(VikingTheme.VikingButtonStyle())
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .onAppear {
            VikingTheme.configureNavigationBarStyle()
        }
    }
}

#Preview {
    ContentView()
}
