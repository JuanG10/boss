shader_type canvas_item;

uniform float progress : hint_range(0, 1);

uniform sampler2D image;

const float diamondPixelSize = 100f;

void fragment() {
    float xFraction = fract(FRAGCOORD.x / diamondPixelSize);
    float yFraction = fract(FRAGCOORD.y / diamondPixelSize);
    
    float xDistance = abs(xFraction - 0.5);
    float yDistance = abs(yFraction - 0.5);
    
    if (xDistance + yDistance > progress) {
        COLOR = texture(image,UV);
    } else {
        COLOR = texture(TEXTURE,UV);
    }
}