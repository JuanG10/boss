extends CanvasLayer


var position 
var habilidades_agregadas = []
var player  
var habilitar_habilidad_orange   		  = true
var habilitar_habilidad_disparo_explosivo = true
var habilitar_blue = true
var limpieza_orange = true
var limpieza_blue   = true
var limpieza_red    = true




var habilidades_agregadas_orange = []



const HABILIDADES = {
	DASH = preload("res://Habilidades/Dash.tscn"),
	DISPARO_EXPLOSIVO = preload("res://Habilidades/Disparo_explosivo.tscn"),
	Attack_speed      = preload("res://Habilidades/Attack_speed.tscn")
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
		limpieza_de_orange()
	elif habilitar_habilidad_disparo_explosivo && condition_skill("Red","Disparo explosivo"):
		remove_childs()
		limpiza_de_red()
		var disparo_explosivo = HABILIDADES.DISPARO_EXPLOSIVO.instance()
		add_habilidad_position(disparo_explosivo)
		habilitar_habilidad_disparo_explosivo = false
	elif habilitar_blue && condition_skill("Blue","Attack_speed"):
		remove_childs()
		limpieza_de_blue()
		var attack_speed = HABILIDADES.Attack_speed.instance()
		add_habilidad_position(attack_speed)
		habilitar_blue = false
	elif player.color_actual() == "Orange" && !condition_skill("Orange","Dash") && limpieza_orange:
		 remove_childs()
		 limpieza_orange = false
		 limpieza_de_orange()
	elif player.color_actual() == "Blue" && !condition_skill("Blue","Attack_speed") && limpieza_blue:
		remove_childs()
		limpieza_blue = false
		limpieza_de_blue()
	elif player.color_actual() == "Red" && 	!condition_skill("Red","Disparo explosivo") && limpieza_red:
		remove_childs()
		limpieza_red = false
		limpiza_de_red()


func limpiza_de_red():
	limpieza_orange = true
	limpieza_blue = true

func limpieza_de_blue():
	limpieza_orange = true
	limpieza_red   =  true
	
func limpieza_de_orange():
	limpieza_blue   = true
	limpieza_red    = true





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
	elif name_habilidad.get_name() == "Attack_speed":
		habilitar_blue = true	
		
