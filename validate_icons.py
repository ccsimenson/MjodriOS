#!/usr/bin/env python3
import os
import json
import sys
from PIL import Image
import pathlib

class IconValidator:
    def __init__(self, assets_path):
        self.assets_path = pathlib.Path(assets_path)
        self.appiconset = self.assets_path / "AppIcon.appiconset"
        self.errors = []
        self.warnings = []

    def validate(self):
        print("\n🔍 Validating App Icons for Mjöðr Calculator...")
        
        # Check directory exists
        if not self.appiconset.exists():
            self.errors.append("❌ AppIcon.appiconset directory not found")
            return False

        # Read Contents.json
        try:
            with open(self.appiconset / "Contents.json") as f:
                contents = json.load(f)
        except Exception as e:
            self.errors.append(f"❌ Failed to read Contents.json: {e}")
            return False

        # Validate each image
        for image in contents.get("images", []):
            self._validate_image(image)

        # Report results
        self._print_report()
        
        return len(self.errors) == 0

    def _validate_image(self, image_spec):
        # Only validate iOS-specific icons
        idiom = image_spec.get("idiom", "")
        if idiom not in ["iphone", "ipad", "ios-marketing"]:
            return

        filename = image_spec.get("filename")
        if not filename:
            self.warnings.append("⚠️ Image spec missing filename")
            return

        file_path = self.appiconset / filename
        if not file_path.exists():
            # Extract size and scale for error message
            size = image_spec.get("size", "unknown")
            scale = image_spec.get("scale", "1x")
            self.errors.append(f"❌ Missing icon: {filename} ({size} @{scale} for {idiom})")
            return

        try:
            with Image.open(file_path) as img:
                # Check format
                if img.format != "PNG":
                    self.errors.append(f"❌ {filename} is not PNG format")

                # Check size
                expected_size = image_spec["size"].split("x")
                expected_width = int(float(expected_size[0]))
                expected_height = int(float(expected_size[0]))
                scale = int(image_spec.get("scale", "1").replace("x", ""))
                expected_width *= scale
                expected_height *= scale

                if img.width != expected_width or img.height != expected_height:
                    self.errors.append(
                        f"❌ {filename} size mismatch: "
                        f"Expected {expected_width}x{expected_height}, "
                        f"got {img.width}x{img.height}"
                    )

                # Check color mode
                if img.mode != "RGB" and img.mode != "RGBA":
                    self.warnings.append(
                        f"⚠️ {filename} uses {img.mode} color mode "
                        f"(should be RGB or RGBA)"
                    )

                # Check for alpha channel in App Store icon
                if (filename == "Icon-1024.png" and img.mode == "RGBA"):
                    self.errors.append(
                        f"❌ App Store icon ({filename}) should not have "
                        "transparency"
                    )

                # Check bit depth
                if img.mode == "RGB" and img.getbands() != ("R", "G", "B"):
                    self.warnings.append(
                        f"⚠️ {filename} has unusual bit depth"
                    )

        except Exception as e:
            self.errors.append(f"❌ Failed to validate {filename}: {e}")

    def _print_report(self):
        print("\n📊 Validation Report")
        print("=================")
        
        if not self.errors and not self.warnings:
            print("✅ All icons passed validation!\n")
            return

        if self.errors:
            print("\n❌ Errors:")
            for error in self.errors:
                print(f"  {error}")

        if self.warnings:
            print("\n⚠️ Warnings:")
            for warning in self.warnings:
                print(f"  {warning}")

        print("\n")

def main():
    if len(sys.argv) != 2:
        print("Usage: validate_icons.py <path_to_Assets.xcassets>")
        sys.exit(1)

    validator = IconValidator(sys.argv[1])
    success = validator.validate()
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
