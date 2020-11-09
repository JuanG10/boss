extends CanvasLayer


var position 
var posi_y = 0
var habilidad_verde = false
var habilidad_rojo  = true 
var habilidad_azul  = true
var scene 
var habilidades_agregadas = []
var active_verde = true

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
	#set_text("Habilidades: ")
	position = get_parent()
		
func on_update():
	#set_text("Habilidades: " + str(GlobalVariables.money))
	pass


func set_names_habilidades():
	for name_habilidad in GlobalVariables.habilidadres:
		set_sprite_habilidad_rojo(name_habilidad)
		set_sprite_habilidad_azul(name_habilidad)
		set_sprite_habilidad_verde(name_habilidad)
		
		
func _physics_process(delta):
	pepe()

		
func pepe():
	set_habilidad_verde()
	if habilidad_verde && GlobalVariables.habilidadres.size() > 0 && active_verde:
		set_names_habilidades()
		active_verde = false
	elif !active_verde  && GlobalVariables.habilidadres.size()> 0 && get_parent().color_actual() != "Verde":
		print("pepepepeppe")
		limpiar_habilidades()
		habilidad_verde = true	
		
	
func set_habilidad_verde():
	if get_parent().color_actual() == "Verde":
		habilidad_verde = true
	else:
		habilidad_verde = false			
		
		
		
func set_sprite_habilidad_rojo(name_habilidad):
	if get_parent().color_actual() == "Rojo":	
		if name_habilidad == "atk_speed":
			scene = HABILIDADES.BALA.instance()
			add_child(scene)
			set_icono_habilidad('Bala')
		elif name_habilidad == "Speed":
			scene = HABILIDADES.SPEED.instance()
			add_child(scene)	
			set_icono_habilidad('speed')
		elif name_habilidad == "damage":
			scene = HABILIDADES.PISTOLA_2.instance()
			add_child(scene)
			set_icono_habilidad('Pistola_2')
		elif name_habilidad == "damage_1":
			scene = HABILIDADES.PISTOLA.instance()
			add_child(scene)
			set_icono_habilidad('Pistola')
		elif name_habilidad == "Cuchillo":
			scene = HABILIDADES.CUCHILLO.instance()
			add_child(scene)
			set_icono_habilidad(name_habilidad)
			



func set_sprite_habilidad_verde(name_habilidad):
	if	name_habilidad == "shield" && get_parent().color_actual() == "Verde":
		scene = HABILIDADES.ESCUDO.instance()
		habilidades_agregadas.append(scene)
		add_child(HABILIDADES.ESCUDO.instance())
		set_icono_habilidad('Escudo')
		active_verde = false



func set_sprite_habilidad_azul(name_habilidad):
	if name_habilidad == 'Corazon' && get_parent().color_actual() == "Azul":
		limpiar_habilidades()
		scene = HABILIDADES.CORAZON.instance()
		add_child(scene)
		set_icono_habilidad(name_habilidad)
		habilidad_azul = false





func set_icono_habilidad(name_habilidad):
		get_node(name_habilidad).position.x += get_node("Position2D").position.x + posi_y
		get_node(name_habilidad).position.y += get_node("Position2D").position.y
		posi_y += 25


func limpiar_habilidades():
	for habilidad in habilidades_agregadas:
		remove_child(habilidad)
		print("for")
	posi_y = 0

