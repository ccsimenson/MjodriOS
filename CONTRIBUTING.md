# Contributing to Mjöðr

Welcome to the mead hall, fellow developer! We're thrilled that you want to contribute to Mjöðr. Like the Vikings who shared their knowledge of mead-making, we believe in the power of community collaboration.

## Code of Conduct

In the spirit of Viking honor, we expect all contributors to:
- Show respect to fellow contributors
- Provide constructive feedback
- Accept criticism with grace
- Help maintain the app's Norse aesthetic and theme

## Getting Started

1. **Fork the Repository**
   ```bash
   # Clone your fork
   git clone https://github.com/your-username/MjodriOS.git
   cd MjodriOS
   
   # Add the upstream repository
   git remote add upstream https://github.com/ccsimenson/MjodriOS.git
   ```

2. **Create a Branch**
   ```bash
   # Create and switch to a new branch
   git checkout -b feature/your-feature-name
   ```

## Development Guidelines

### Code Style
- Follow Swift style guidelines
- Use descriptive Norse-inspired naming
- Maintain the existing Viking theme
- Document your code thoroughly

### SwiftUI Best Practices
- Use SwiftUI views and modifiers
- Follow MVVM architecture
- Keep views modular and reusable
- Maintain the established color scheme:
  ```swift
  // Color examples
  static let darkWood = Color(hex: "#2C1810")
  static let lightWood = Color(hex: "#B08968")
  static let softGold = Color(hex: "#DAA520")
  static let deepRed = Color(hex: "#8B0000")
  static let parchment = Color(hex: "#F5E6D3")
  ```

### Testing
1. **Unit Tests**
   - Write tests for calculations
   - Test view models
   - Verify data persistence

2. **UI Testing**
   - Test on multiple devices
   - Verify theme consistency
   - Check accessibility

### Commit Messages
Structure your commits like a Viking saga:
```
feat: Add new mead recipe calculation
- Implemented temperature correction
- Added Plato to gravity conversion
- Updated UI with Norse styling
```

## Pull Request Process

1. **Before Submitting**
   - Update documentation
   - Add necessary tests
   - Verify all tests pass
   - Check theme consistency

2. **PR Description**
   - Describe changes clearly
   - Reference related issues
   - Include screenshots for UI changes
   - List any new dependencies

3. **Review Process**
   - Address review comments
   - Keep discussions constructive
   - Be patient with feedback

## Feature Requests

When proposing new features:
1. Check existing issues first
2. Describe the feature's purpose
3. Explain how it fits the Viking theme
4. Provide mockups if possible

## Bug Reports

When reporting bugs:
1. Use the bug report template
2. Include reproduction steps
3. List environment details:
   - iOS version
   - Device model
   - App version

## Questions?

Need help? Reach out through:
- GitHub Issues
- Pull Request comments
- Project discussions

May your code be as strong as Viking mead! Skål! 🍻

## License
By contributing, you agree that your contributions will be licensed under the MIT License.
