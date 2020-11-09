extends CanvasLayer


var position 
var posi_y = 0
var scene 
var habilidades_agregadas = []
var player  
var habilitar_habilidad_green = true
var habilitar_habilidad_red   = true
var habilitar_habilidad_blue  = true 



var habilidades_agregadas_verde = []
var habilidades_agregadas_rojo  = []
var habilidades_agregadas_azul  = []


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


func _physics_process(delta):
	set_habilidades()


func set_habilidades():
	var list_habi_green = GlobalVariables.habilidades_Green
	var list_habi_red   = GlobalVariables.habilidades_Red
	var list_habi_blu   = GlobalVariables.habilidades_Blue
	if player.color_actual() == "Green" && habilitar_habilidad_green && list_habi_green.size() > 0:
		habilidades_green(list_habi_green)
		habilitar_habilidad_green = false
	if player.color_actual() == "Red" && habilitar_habilidad_red && list_habi_red.size() > 0:
		habilidades_red(list_habi_red)
		habilitar_habilidad_red = false
	if player.color_actual() == "Blue" && habilitar_habilidad_blue && list_habi_blu.size() > 0:
		habilidades_blue(list_habi_blu)
		habilitar_habilidad_blue = false
	if player.color_actual() != "Red" && !habilitar_habilidad_red:
		limpiar_habilidades_Red()
		habilitar_habilidad_red = true
	if player.color_actual() != "Blue" && !habilitar_habilidad_blue:
		limpiar_habilidades_Blue()
		habilitar_habilidad_blue = true
	if player.color_actual() != "Green" && !habilitar_habilidad_green:
		limpiar_habilidades_Green()		
		habilitar_habilidad_green = true

	

		


	
func habilidades_green(lista_habilidades):
	for name_habilidad in lista_habilidades:
		set_sprite_habilidad_verde(name_habilidad)

func habilidades_red(lista_habilidades):
	for name_habilidad in lista_habilidades:
		set_sprite_habilidad_rojo(name_habilidad)

func habilidades_blue(lista_habilidades):
	for name_habilidad in lista_habilidades:
		set_sprite_habilidad_azul(name_habilidad)
							
	
#Agrega como hijo/s al canvasLayer los iconos de las habilidades del estado rojo
func set_sprite_habilidad_rojo(name_habilidad):
		var name = ""
		if name_habilidad == "atk_speed":
			scene = HABILIDADES.BALA.instance()
			name = "Bala"
		elif name_habilidad == "Speed":
			scene = HABILIDADES.SPEED.instance()
			name = "speed"
			print(scene)
		elif name_habilidad == "damage":
			scene = HABILIDADES.PISTOLA_2.instance()
			name = "Pistola_2"
		elif name_habilidad == "damage_1":
			scene = HABILIDADES.PISTOLA.instance()
			name  = "Pistola" 
		elif name_habilidad == "Cuchillo":
			name = "Cuchillo"
			scene = HABILIDADES.CUCHILLO.instance()
		add_child(scene)
		habilidades_agregadas_rojo.append(scene)
		set_icono_habilidad(name)



#Lo mismo pero las habilidades del estado verde
func set_sprite_habilidad_verde(name_habilidad):
	if	name_habilidad == "shield":
		scene = HABILIDADES.ESCUDO.instance()
		add_child(scene)
		habilidades_agregadas_verde.append(scene)
		set_icono_habilidad('Escudo')

#Con el estado azul
func set_sprite_habilidad_azul(name_habilidad):
	if name_habilidad == 'Corazon':
		scene = HABILIDADES.CORAZON.instance()
		add_child(scene)
		habilidades_agregadas_azul.append(scene)
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
	habilidades_agregadas = []	
	posi_y = 0
	
func limpiar_habilidades_Green():
	for habilidad in habilidades_agregadas_verde:
		remove_child(habilidad)
	habilidades_agregadas_verde = []
	posi_y = 0		
	
func limpiar_habilidades_Red():
	for habilidad in habilidades_agregadas_rojo:
		remove_child(habilidad)
	habilidades_agregadas_rojo = []
	posi_y = 0		

func limpiar_habilidades_Blue():
	for habilidad in habilidades_agregadas_azul:
		remove_child(habilidad)
	habilidades_agregadas_azul = []
	posi_y = 0		









