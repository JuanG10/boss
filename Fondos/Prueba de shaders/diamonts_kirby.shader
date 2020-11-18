shader_type canvas_item;

// An input into the shader from our game code.
// Ranges from 0 to 1 over the course of the transition.
// We use this to actually animate the shader.
uniform float progress : hint_range(0, 1);

// Size of each diamond, in pixels.
uniform float diamondPixelSize = 10f;

void fragment() {
    // We need to fill in this function!
    // Here, FRAGCOORD.xy gives us the screen coordinates of the current pixel
    // (ranging from 0 to screenwidth/screenheight).
    // UV.xy gives us the same thing, but normalized to 0-1.
    
    float xFraction = fract(FRAGCOORD.x / diamondPixelSize);
    float yFraction = fract(FRAGCOORD.y / diamondPixelSize);
    // We need to fill in this logic.
    if (xFraction + yFraction > progress * 2f) {
		// Tells the shader to not render this pixel.
        discard;
    }
}