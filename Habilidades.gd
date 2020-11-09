extends CanvasLayer


var position 
var posi_y = 0
var scene 
var habilidades_agregadas = []
var player 

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
	position = get_parent()
	player   = get_parent().get_parent().get_node("Player")
		
func _physics_process(delta):
	#print(player.habilidades_player())
	pass
	
	
func set_names_habilidades():
	for name_habilidad in player.habilidades_player():
		set_sprite_habilidad_rojo(name_habilidad)
		set_sprite_habilidad_azul(name_habilidad)
		set_sprite_habilidad_verde(name_habilidad)
	
		
		
		
func set_sprite_habilidad_rojo(name_habilidad):
	if get_parent().color_actual() == "Rojo":	
		if name_habilidad == "atk_speed":
			scene = HABILIDADES.BALA.instance()
		elif name_habilidad == "Speed":
			scene = HABILIDADES.SPEED.instance()
		elif name_habilidad == "damage":
			scene = HABILIDADES.PISTOLA_2.instance()
		elif name_habilidad == "damage_1":
			scene = HABILIDADES.PISTOLA.instance()
		elif name_habilidad == "Cuchillo":
			scene = HABILIDADES.CUCHILLO.instance()
		add_child(scene)
		set_icono_habilidad(name_habilidad)



func set_sprite_habilidad_verde(name_habilidad):
	if	name_habilidad == "shield":
		scene = HABILIDADES.ESCUDO.instance()
		add_child(scene)
		set_icono_habilidad('Escudo')




func set_sprite_habilidad_azul(name_habilidad):
	if name_habilidad == 'Corazon':
		limpiar_habilidades()
		scene = HABILIDADES.CORAZON.instance()
		add_child(scene)
		set_icono_habilidad(name_habilidad)






func set_icono_habilidad(name_habilidad):
		var icono_habilidad   		= get_node(name_habilidad)
		icono_habilidad.position.x += get_node("Position2D").position.x + posi_y
		icono_habilidad.position.y += get_node("Position2D").position.y
		posi_y += 25


func limpiar_habilidades():
	for habilidad in habilidades_agregadas:
		remove_child(habilidad)
	posi_y = 0

