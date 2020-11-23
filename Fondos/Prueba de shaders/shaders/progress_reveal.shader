shader_type canvas_item;

uniform float progress : hint_range(0, 1);

uniform sampler2D image;

const float diamontSize = 10f;

void fragment() {
    float xFraction = fract(FRAGCOORD.x / diamontSize);
    float yFraction = fract(FRAGCOORD.y / diamontSize);
    
    float xDistance = abs(xFraction - 0.5);
    float yDistance = abs(yFraction - 0.5);
    
    if (xDistance + yDistance + UV.x + UV.y > progress * 3f) {
        COLOR = texture(image,UV);
    } else {
		COLOR = texture(TEXTURE,UV);
	}
}