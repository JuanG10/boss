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
	player   =  get_parent().get_parent().get_node("Player")
	

func set_habilidades():
	var list_habi_green = player.get_child(0)
	habilidades_green(list_habi_green)
	
func habilidades_green(lista_habilidades):
	for name_habilidad in lista_habilidades:
		set_sprite_habilidad_verde(name_habilidad)	
	
#Agrega como hijo/s al canvasLayer los iconos de las habilidades del estado rojo
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



#Lo mismo pero las habilidades del estado verde
func set_sprite_habilidad_verde(name_habilidad):
	if	name_habilidad == "shield":
		scene = HABILIDADES.ESCUDO.instance()
		add_child(scene)
		set_icono_habilidad('Escudo')

#Con el estado azul
func set_sprite_habilidad_azul(name_habilidad):
	if name_habilidad == 'Corazon':
		limpiar_habilidades()
		scene = HABILIDADES.CORAZON.instance()
		add_child(scene)
		set_icono_habilidad(name_habilidad)



#Al icono que representa la habilidad del player lo agrega al CanvasLayer y le da un position
func set_icono_habilidad(name_habilidad):
		var icono_habilidad   		= get_node(name_habilidad)
		var position2d              = get_node("Position2D")
		icono_habilidad.position.x += position2d.position.x + posi_y
		icono_habilidad.position.y += position2d.position.y
		posi_y += 25


#Borra las habilidades agregadas 
func limpiar_habilidades():
	for habilidad in habilidades_agregadas:
		remove_child(habilidad)
	posi_y = 0

