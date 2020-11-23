shader_type canvas_item;

uniform sampler2D image;

uniform float progress: hint_range(0,1);

uniform vec2 center = vec2(0.5,0.5);

const float diamontSize = 5f;

void fragment() {
	float xFraction = fract(FRAGCOORD.x / diamontSize);
    float yFraction = fract(FRAGCOORD.y / diamontSize);
    
    float xDistance = abs(xFraction - 0.5);
    float yDistance = abs(yFraction - 0.5);
	
	if (xDistance + yDistance + distance(center, UV) < progress * 2f) {
        COLOR = texture(image,UV);
    } else {
		COLOR = texture(TEXTURE,UV);
	}
}