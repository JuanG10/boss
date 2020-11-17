extends CanvasLayer


var position 
var habilidades_agregadas = []
var player  
var habilitar_habilidad_orange   		  = true
var habilitar_habilidad_disparo_explosivo = true
var habilitar_blue = true




var habilidades_agregadas_orange = []



const HABILIDADES = {
	DASH = preload("res://Habilidades/Dash.tscn"),
	DISPARO_EXPLOSIVO = preload("res://Habilidades/Disparo_explosivo.tscn")
}


func _ready():
	position = get_node("Habilidades/Position2D")
	player   =  get_parent().get_parent().get_node("Player")

func _physics_process(_delta):
	set_habilidades()


func set_habilidades():
	if habilitar_habilidad_orange && condition_skill("Orange","Dash"):
		remove_childs()
		var dash = HABILIDADES.DASH.instance()
		add_habilidad_position(dash)
		habilitar_habilidad_orange = false
	elif habilitar_habilidad_disparo_explosivo && condition_skill("Red","Disparo explosivo"):
		remove_childs()
		var disparo_explosivo = HABILIDADES.DISPARO_EXPLOSIVO.instance()
		add_habilidad_position(disparo_explosivo)
		habilitar_habilidad_disparo_explosivo = false
	elif player.color_actual() == "Blue" && habilitar_blue && habilidades_agregadas.size() > 0:
		habilitar_blue = false
		remove_childs()	

func condition_skill(color,name_habilidad):
	return player.color_actual() == color && player.posee_habilidad(name_habilidad)

func add_habilidad_position(scene):
	scene.position.x = position.position.x 
	scene.position.y = position.position.y
	position.add_child(scene)
	habilidades_agregadas.append(scene)
	habilitar_blue = true	

func remove_childs():
	for habilidad in habilidades_agregadas:
		habilitar_habilidad(habilidad)
		position.remove_child(habilidad)




func habilitar_habilidad(name_habilidad):
	if name_habilidad.get_name() == "Disparo_explosivo":
		habilitar_habilidad_disparo_explosivo = true
	elif name_habilidad.get_name() == "Dash":
		habilitar_habilidad_orange = true	
		
