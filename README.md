# Mjöðr - Viking Mead Calculator

![License](https://img.shields.io/badge/license-MIT-blue.svg)

A beautiful iOS app for calculating, tracking, and crafting mead in the Viking tradition. Featuring a stunning Norse-inspired design with authentic Viking aesthetics.

## 🎨 Viking Theme

Mjöðr is crafted with an authentic Viking aesthetic:

- **Color Palette**
  - Dark Wood Brown (`#2C1810`) - Primary background
  - Light Wood Brown (`#B08968`) - Interactive elements
  - Soft Gold (`#DAA520`) - Accents and highlights
  - Deep Red (`#8B0000`) - Active states and emphasis
  - Parchment (`#F5E6D3`) - Text on dark backgrounds

- **Design Elements**
  - Norse-inspired typography with Papyrus font
  - Raised relief buttons with 10px padding
  - Traditional Viking patterns and decorations
  - Custom app icon featuring a drinking horn

- **Norse Naming**
  - "Sacred Measurements" - ABV Calculator
  - "Wisdom of Odin" - Recipe Database
  - "Ancient Recipes" - Brewing Guide
  - "Mead Hall" - Batch Tracking
  - "Runes of Knowledge" - Help Section

## TestFlight Preparation Guide

### Prerequisites
1. Apple Developer Account
2. Xcode 15.0 or later
3. iOS device running iOS 15.0 or later

### Setup Steps

1. **Xcode Project Setup**
   - Open Xcode and create a new project
   - Choose "App" under iOS
   - Set Product Name as "Mjodr"
   - Set Organization Identifier (e.g., com.yourname.mjodr)
   - Choose SwiftUI for interface
   - Select your team
   - Enable CoreData

2. **Copy Project Files**
   Copy all Swift files into your Xcode project:
   ```
   ├── App Core
   │   ├── MjodriOSApp.swift
   │   ├── ContentView.swift
   │   └── VikingTheme.swift
   ├── Features
   │   ├── Strength Calculator
   │   │   ├── StrengthCalculatorView.swift
   │   │   ├── StrengthCalculatorViewModel.swift
   │   │   └── Calculations.swift
   │   ├── Recipe Search
   │   │   ├── RecipeSearchView.swift
   │   │   └── MeadType.swift
   │   ├── Mead Hall
   │   │   ├── MeadHallView.swift
   │   │   └── MeadBatch.swift
   │   └── Help
   │       └── RunesView.swift
   ```

3. **Configure Signing & Capabilities**
   - In Xcode, select your project
   - Choose your target
   - Under Signing & Capabilities:
     - Select your team
     - Set Bundle Identifier
     - Enable automatic signing

4. **Version Configuration**
   - Set Version to 1.0
   - Set Build to 1
   - Update Info.plist with correct values

5. **TestFlight Preparation**
   - Archive your app (Product > Archive)
   - Upload to App Store Connect
   - Complete TestFlight Information:
     - Test Information
     - Beta App Description
     - Beta App Feedback Email
     - Privacy Policy URL
     - Contact Information

6. **Required Assets**
   - App Icon (All required sizes)
   - Screenshots for different devices
   - App Privacy Details
   - App Store Description

### Testing

Before submitting to TestFlight:

1. **Local Testing**
   - Test on multiple iOS devices
   - Verify all calculations
   - Check CoreData persistence
   - Test YouTube integration
   - Verify UI in different orientations

2. **Performance Testing**
   - Test with multiple batches
   - Verify memory usage
   - Check battery consumption
   - Test background behavior

3. **UI/UX Testing**
   - Verify Viking theme consistency
   - Test accessibility features
   - Check dark mode compatibility
   - Verify iPad layout

### Known Issues
- None currently identified

### Support
For TestFlight support, contact: [Your Email]

## App Features

1. **Strength Calculator**
   - Temperature-corrected gravity readings
   - Standard and advanced ABV calculations
   - Plato conversion
   - Real-time updates

2. **Ancient Recipes**
   - 8 traditional mead styles
   - YouTube integration
   - Detailed descriptions
   - Interactive UI

3. **Mead Hall**
   - Batch tracking
   - Progress monitoring
   - Temperature tracking
   - Notes and status management

4. **Runes of Knowledge**
   - Feature guides
   - Brewing formulas
   - Expert tips
   - Norse-themed help

## Technical Requirements
- iOS 15.0+
- iPhone and iPad support
- Internet connection for recipe search

## Installation

### From Source
1. Clone the repository:
   ```bash
   git clone https://github.com/ccsimenson/MjodriOS.git
   ```
2. Open the project in Xcode
3. Configure signing with your Apple Developer account
4. Build and run on your device

### TestFlight (Coming Soon)
1. Request access to the TestFlight beta
2. Install TestFlight on your iOS device
3. Accept the invitation and install Mjöðr

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
- Inspired by traditional Viking mead-making techniques
- Built with SwiftUI and modern iOS technologies
- Icon designed with authentic Norse aesthetics
