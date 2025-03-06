from PIL import Image, ImageDraw, ImageFont, ImageEnhance
import math
from pathlib import Path

def create_gradient(width, height, start_color, end_color):
    gradient = Image.new('RGBA', (width, height))
    draw = ImageDraw.Draw(gradient)
    
    for y in range(height):
        r = int(start_color[0] + (end_color[0] - start_color[0]) * y / height)
        g = int(start_color[1] + (end_color[1] - start_color[1]) * y / height)
        b = int(start_color[2] + (end_color[2] - start_color[2]) * y / height)
        draw.line([(0, y), (width, y)], fill=(r, g, b))
    
    return gradient

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def create_master_icon():
    # Create a new image with dark wood background
    size = 1024
    padding = size // 8
    img = Image.new('RGB', (size, size), '#2C1810')
    draw = ImageDraw.Draw(img)
    
    # Add wood grain effect
    for i in range(0, size, 4):
        opacity = int(30 * math.sin(i * 0.1)) + 10
        draw.line([(0, i), (size, i)], fill='#1A0F0A', width=1)
    
    # Calculate dimensions for the drinking horn
    center_x = size // 2
    center_y = size // 2
    horn_width = int(size * 0.75)  # 75% of image width
    horn_height = int(size * 0.6)   # 60% of image height
    
    # Create the main horn curve points
    points = []
    for t in range(120):
        angle = math.radians(t * 0.75)
        curve = math.sin(angle * 0.5) * 0.3
        x = center_x + int(math.cos(angle) * horn_width * 0.4 * (1 - curve))
        y = center_y + int(math.sin(angle) * horn_height * 0.8)
        points.append((x, y))
    
    # Add points for the horn's body with a more natural curve
    base_x = points[-1][0]
    base_y = points[-1][1]
    points.extend([
        (base_x - 100, base_y + 50),
        (center_x - horn_width//2, center_y + horn_height//3),
        (center_x - horn_width//2 + 100, center_y + horn_height//2),
        (center_x - horn_width//3, center_y + horn_height//3)
    ])
    
    # Draw the main horn shape
    draw.polygon(points, outline='#8B0000', fill='#DAA520', width=6)
    
    # Add shading and highlights
    for i in range(5):
        offset = i * 4
        shade_points = [(x + offset, y + offset) for x, y in points[:len(points)//2]]
        draw.line(shade_points, fill='#8B4513', width=2)
    
    # Add Norse runes along the horn's body
    runes = ["ᚠ", "ᚱ", "ᚦ", "ᚨ", "ᚹ"]  # Elder Futhark runes
    try:
        font = ImageFont.truetype("Arial Unicode.ttf", size=60)
        for i, rune in enumerate(runes):
            x = center_x - horn_width//3 + i * 80
            y = center_y + horn_height//3
            draw.text((x, y), rune, fill='#8B0000', font=font)
    except Exception:
        # Fallback decorative patterns if font not available
        for i in range(5):
            x1 = center_x - horn_width//3 + i * 80
            y1 = center_y + horn_height//3
            draw.line([(x1, y1), (x1+40, y1)], fill='#8B0000', width=4)
            draw.line([(x1+20, y1-10), (x1+20, y1+10)], fill='#8B0000', width=4)
    
    # Add metallic rim effect
    rim_points = points[:len(points)//3]
    draw.line(rim_points, fill='#FFD700', width=3)
    for i in range(2):
        offset = i * 2
        highlight_points = [(x-offset, y-offset) for x, y in rim_points]
        draw.line(highlight_points, fill='#FFFFFF', width=1)
    
    # Add a subtle glow effect
    glow = img.copy()
    glow = ImageEnhance.Brightness(glow).enhance(1.2)
    img = Image.blend(img, glow, 0.3)
    
    return img

def generate_all_sizes():
    # Create the master icon
    master_icon = create_master_icon()
    
    # Ensure the AppIcon.appiconset directory exists
    icon_dir = Path('Assets.xcassets/AppIcon.appiconset')
    icon_dir.mkdir(parents=True, exist_ok=True)
    
    # Define all required sizes
    icon_sizes = {
        # iPhone
        'Icon-20@2x.png': (40, 40),   # Notifications 2x
        'Icon-20@3x.png': (60, 60),   # Notifications 3x
        'Icon-29@2x.png': (58, 58),   # Settings 2x
        'Icon-29@3x.png': (87, 87),   # Settings 3x
        'Icon-40@2x.png': (80, 80),   # Spotlight 2x
        'Icon-40@3x.png': (120, 120),  # Spotlight 3x
        'Icon-60@2x.png': (120, 120),  # App Icon 2x
        'Icon-60@3x.png': (180, 180),  # App Icon 3x
        
        # iPad
        'Icon-20.png': (20, 20),      # Notifications 1x
        'Icon-20@2x.png': (40, 40),   # Notifications 2x
        'Icon-29.png': (29, 29),      # Settings 1x
        'Icon-29@2x.png': (58, 58),   # Settings 2x
        'Icon-40.png': (40, 40),      # Spotlight 1x
        'Icon-40@2x.png': (80, 80),   # Spotlight 2x
        'Icon-76.png': (76, 76),      # App Icon 1x
        'Icon-76@2x.png': (152, 152),  # App Icon 2x
        'Icon-83.5@2x.png': (166, 166),  # iPad Pro
        
        # App Store
        'Icon-1024.png': (1024, 1024)  # App Store
    }
    
    # Generate each size
    for filename, size in icon_sizes.items():
        resized = master_icon.resize(size, Image.Resampling.LANCZOS)
        icon_path = icon_dir / filename
        resized.save(icon_path, 'PNG')
        print(f"Generated: {filename} ({size[0]}x{size[1]})")

if __name__ == "__main__":
    generate_all_sizes()
