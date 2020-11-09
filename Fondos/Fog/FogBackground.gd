extends Sprite

const COLORS = {
	0 : Vector3(0.35, 0.45, 0.8), # Azul
	1 : Vector3(0.25, 0.88, 0.35),  # Verde
	2 : Vector3(0.85, 0.38, 0.35) # Rojo
}

var pos:int = 0

func change_bg_color_by_position(pos:int)->void:
	material.set_shader_param("color", COLORS[pos])

func change_bg_color(next:bool)->void:
	if next: pos = (pos + 1) % COLORS.size()
	else: pos = (pos + 2) % COLORS.size()
	material.set_shader_param("color", COLORS[pos])

func change_bg_octaves(octaves:int)->void:
	material.set_shader_param("OCTAVES", octaves + 1)
	material.set_shader_param("acceleration", (octaves/10.0) + 0.5)
