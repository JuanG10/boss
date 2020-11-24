shader_type canvas_item;

uniform float progress : hint_range(0, 1);

uniform sampler2D image;

const float diamondPixelSize = 100f;

void fragment() {
    // Here, FRAGCOORD.xy gives us the screen coordinates of the current pixel
    // (ranging from 0 to screenwidth/screenheight).
    // UV.xy gives us the same thing, but normalized to 0-1.
    
    float xFraction = fract(FRAGCOORD.x / diamondPixelSize);
    float yFraction = fract(FRAGCOORD.y / diamondPixelSize);
    if (xFraction + yFraction > progress * 2f) {
		// Tells the shader to not render this pixel.
        COLOR = texture(image,UV);
    } else {
		COLOR = texture(TEXTURE,UV);
	}
}