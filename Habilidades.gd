extends Label


var position 
var posi_y = 0

const HABILIDADES = {
	ESCUDO 	= preload("res://Habilidades/Escudo.tscn"),
	PISTOLA = preload("res://Habilidades/Pistola.tscn"),
	BALA    = preload("res://Habilidades/Bala.tscn")
}

func _ready():
	set_text("Habilidades: ")
	position = get_parent().get_parent().get_parent().get_node("Position2D")

	set_names_habilidades()
		
func on_update():
	set_text("Habilidades: " + str(GlobalVariables.money))


func set_names_habilidades():
	for name_habilidad in GlobalVariables.habilidadres:
		print(name_habilidad)
		sprite_de_habilidad(name_habilidad)
		
		
		
func sprite_de_habilidad(name_habilidad):
	var scene = null
	
	if	name_habilidad == "shield":
		scene = HABILIDADES.ESCUDO.instance()
		position.add_child(HABILIDADES.ESCUDO.instance())
		position.get_node('Escudo').position.x += posi_y
		posi_y += 25 
	if name_habilidad == "damage":
		scene = HABILIDADES.BALA.instance()
		position.add_child(scene)
	if name_habilidad == "Speed":
		position.add_child(HABILIDADES.PISTOLA.instance())	
		position.get_node('Pistola').position.x += posi_y
		posi_y += 25 
			








