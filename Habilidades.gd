extends CanvasLayer


var position 
var posi_y = 0
var scene 
var habilidades_agregadas = []
var player  
var habilitar_habilidad_orange   = true




var habilidades_agregadas_orange = []



const HABILIDADES = {
	DASH = preload("res://Habilidades/Dash.tscn")
}


func _ready():
	position = get_node("Habilidades/Position2D")
	player   =  get_parent().get_parent().get_node("Player")


func _physics_process(_delta):
	set_habilidades()


func set_habilidades():
	if habilitar_habilidad_orange && player.color_actual() == "Blue":
		var dash = HABILIDADES.DASH.instance()
		dash.position.x = position.position.x 
		dash.position.y = position.position.y
		position.add_child(dash)
		habilitar_habilidad_orange = false
