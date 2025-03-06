# Mjöðr App Icon Validation Tool

A Python-based validation tool for ensuring your iOS app icons meet Apple's specifications.

## Prerequisites

- Python 3.7+
- Pillow library (`pip install Pillow`)

## Usage

```bash
python validate_icons.py path/to/Assets.xcassets
```

## What It Validates

1. **File Presence**
   - Checks all required icon files exist
   - Verifies Contents.json is valid

2. **Image Properties**
   - Dimensions match requirements
   - PNG format
   - Color mode (RGB/RGBA)
   - Bit depth
   - Transparency (forbidden for App Store icon)

3. **Size Requirements**
   iPhone:
   - 180x180 (60pt @3x)
   - 120x120 (60pt @2x)
   - 120x120 (40pt @3x)
   - 80x80  (40pt @2x)
   - 87x87  (29pt @3x)
   - 58x58  (29pt @2x)
   - 60x60  (20pt @3x)
   - 40x40  (20pt @2x)

   iPad:
   - 167x167 (83.5pt @2x)
   - 152x152 (76pt @2x)
   - 76x76  (76pt @1x)
   - 80x80  (40pt @2x)
   - 40x40  (40pt @1x)
   - 58x58  (29pt @2x)
   - 29x29  (29pt @1x)
   - 40x40  (20pt @2x)
   - 20x20  (20pt @1x)

   App Store:
   - 1024x1024

## Error Messages

- ❌ Critical Errors (Must Fix):
  - Missing icon files
  - Wrong dimensions
  - Invalid format
  - Transparency in App Store icon
  - Missing Contents.json

- ⚠️ Warnings (Should Review):
  - Unusual color modes
  - Non-standard bit depth
  - Missing metadata

## Example Output

```
🔍 Validating App Icons for Mjöðr Calculator...

📊 Validation Report
=================
✅ All icons passed validation!
```

Or with errors:

```
🔍 Validating App Icons for Mjöðr Calculator...

📊 Validation Report
=================
❌ Errors:
  Missing icon: Icon-60@3x.png
  Icon-1024.png has transparency (not allowed)

⚠️ Warnings:
  Icon-40@2x.png uses CMYK color mode (should be RGB or RGBA)
```

## Common Issues and Solutions

1. **Missing Files**
   - Ensure all required sizes are exported
   - Check filenames match Contents.json

2. **Wrong Dimensions**
   - Use exact pixel dimensions
   - Account for scale factors

3. **Format Issues**
   - Always export as PNG
   - Use sRGB color space
   - 8-bit per channel

4. **Transparency**
   - Remove alpha channel from 1024x1024
   - Keep alpha for other sizes if needed

## Integration with Xcode

1. Run before building:
   ```bash
   ./validate_icons.py /path/to/Assets.xcassets || exit 1
   ```

2. Add to Build Phase:
   - Open Xcode project
   - Select target
   - Build Phases tab
   - Add Run Script Phase
   - Add validation script

## Support

For issues or questions about the validation tool, please contact the development team.
