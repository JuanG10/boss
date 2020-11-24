extends Sprite

onready var tween = $progress_tween

onready var ancho_pantalla = ProjectSettings.get_setting("display/window/size/width")
onready var alto_pantalla = ProjectSettings.get_setting("display/window/size/height")

var tiempo_transicion:float = 1.1
var fondo_actual:int
var next:bool

const FONDOS = {
	0 : preload("res://Fondos/Prueba de shaders/imagenes_de_fondo/hexagonal_azul.jpg"),
	1 : preload("res://Fondos/Prueba de shaders/imagenes_de_fondo/naranja_vectorial.jpg"),
	2 : preload("res://Fondos/Prueba de shaders/imagenes_de_fondo/rojo_topografico.jpg")
}

func _ready():
	fondo_actual = 0
	texture = FONDOS[fondo_actual]
	get_material().set_shader_param("image",FONDOS[fondo_actual+1])

func start_bg_transition(num_fondo:int, next_or_previous:bool, pos_jugador_x,pos_jugador_y)->void:
	next = next_or_previous
	get_material().set_shader_param("image",
				FONDOS[_next_background_id()])
	get_material().set_shader_param("center", 
	Vector2(pos_jugador_x/ancho_pantalla,pos_jugador_y/alto_pantalla))
	tween.interpolate_property(get_material(),
		"shader_param/progress",0.0,1.0,tiempo_transicion)
	tween.start()
	fondo_actual = num_fondo

func _on_progress_tween_completed()->void:
	texture = FONDOS[fondo_actual]
	get_material().set_shader_param("progress",0.0)

func _next_background_id()->int:
	if next && !fondo_actual >= FONDOS.size() - 1:
		return fondo_actual + 1
	elif !next:
		if fondo_actual == 0:
			return FONDOS.size() - 1
		else: 
			return fondo_actual - 1
	else: return 0
