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

	if habilitar_habilidad_orange && player.color_actual() == "Orange" && player.posee_habilidad("Dash"):
		remove_childs()
		var dash = HABILIDADES.DASH.instance()
		dash.position.x = position.position.x 
		dash.position.y = position.position.y
		position.add_child(dash)
		habilidades_agregadas.append(dash)
		habilitar_habilidad_orange = false
		habilitar_blue = true	
	elif habilitar_habilidad_disparo_explosivo && player.color_actual() == "Red" && player.posee_habilidad("Disparo explosivo"):
		remove_childs()
		var disparo_explosivo = HABILIDADES.DISPARO_EXPLOSIVO.instance()
		disparo_explosivo.position.x = position.position.x 
		disparo_explosivo.position.y = position.position.y
		position.add_child(disparo_explosivo)
		habilidades_agregadas.append(disparo_explosivo)
		habilitar_habilidad_disparo_explosivo = false
		habilitar_blue = true	
	elif player.color_actual() == "Blue" && habilitar_blue && habilidades_agregadas.size() > 0:
		habilitar_blue = false
		remove_childs()	



func remove_childs():
	for habilidad in habilidades_agregadas:
		habilitar_habilidad(habilidad)
		position.remove_child(habilidad)




func habilitar_habilidad(name_habilidad):
	if name_habilidad.get_name() == "Disparo_explosivo":
		habilitar_habilidad_disparo_explosivo = true
	elif name_habilidad.get_name() == "Dash":
		habilitar_habilidad_orange = true	
		
