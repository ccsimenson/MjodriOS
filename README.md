# Mjöðr - Viking Mead Calculator

A beautiful iOS app for calculating, tracking, and crafting mead in the Viking tradition.

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
