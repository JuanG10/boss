extends Label


var position 
var posi_y = 0

const HABILIDADES = {
	ESCUDO 	  = preload("res://Habilidades/Escudo.tscn"),
	PISTOLA   = preload("res://Habilidades/Pistola.tscn"),
	BALA      = preload("res://Habilidades/Bala.tscn"),
	SPEED     = preload("res://Habilidades/speed.tscn"),
	CORAZON   = preload("res://Habilidades/Corazon.tscn"),
	CUCHILLO  = preload("res://Habilidades/Cuchillo.tscn"),
	PISTOLA_2 = preload("res://Habilidades/Pistola_2.tscn")
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
	var scene 
	if	name_habilidad == "shield":
		scene = HABILIDADES.ESCUDO.instance()
		position.add_child(HABILIDADES.ESCUDO.instance())
		set_icono_habilidad('Escudo')
	elif name_habilidad == "atk_speed":
		scene = HABILIDADES.BALA.instance()
		position.add_child(scene)
		set_icono_habilidad('Bala')
	elif name_habilidad == "Speed":
		scene = HABILIDADES.SPEED.instance()
		position.add_child(scene)	
		set_icono_habilidad('speed')
	elif name_habilidad == 'Corazon':
		scene = HABILIDADES.CORAZON.instance()
		position.add_child(scene)
		set_icono_habilidad(name_habilidad) 
	elif name_habilidad == "damage":
		scene = HABILIDADES.PISTOLA_2.instance()
		position.add_child(scene)
		set_icono_habilidad('Pistola_2')
	elif name_habilidad == "damage_1":
		scene = HABILIDADES.PISTOLA.instance()
		position.add_child(scene)
		set_icono_habilidad('Pistola')
	elif name_habilidad == "Cuchillo":
		scene = HABILIDADES.CUCHILLO.instance()
		position.add_child(scene)
		set_icono_habilidad(name_habilidad)


func set_icono_habilidad(name_habilidad):
		position.get_node(name_habilidad).position.x += posi_y
		posi_y += 25



