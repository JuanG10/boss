extends ItemList

onready var parent_name = get_parent().name
const ICON_SIZE = Vector2(100,100)

const intPrecio = 30
const precio = "$" + str(intPrecio) # Debería ir incrementando.

# Iconos. Hardcodeado por ahora.
const BASE = {
	bala = preload("res://Iconos/bala_base.png"),
	limitador = preload("res://Iconos/limitador_base.png"),
	escudo = preload("res://Iconos/defensa_base.png"),
	pistola = preload("res://Iconos/pistola_base.png")
}
##Naranja
const ORANGE = {
	cuchillo = preload("res://Iconos/cuchillo_azul-violeta.png"),
	escudo = preload("res://Iconos/defensa_base.png"),
	pistola = preload("res://Iconos/pistola_azul-violeta.png"),
	dash    = preload("res://Iconos/relampago.png")
}
const BLUE = {
	corazon = preload("res://Iconos/corazon.png")
}

var MONEDA = preload("res://moneda_particula/Moneda_particula.tscn").instance()



func _ready():
	set_fixed_icon_size(ICON_SIZE)
	if parent_name == "RedPanel":
		#add_item("Cuchillo: +Daño a corta distancia contra rojo", ORANGE.cuchillo)
		#add_item("Pistola: +Daño a distancia contra rojo", ORANGE.pistola)
		#add_item("Bala: +Cadencia " + precio, BASE.bala) 
		pass
	elif parent_name == "GreenPanel":
		add_item("Dash: +Velocidad " + precio, ORANGE.dash) #2
	elif parent_name == "BluePanel":
		pass
		#add_item("Corazon: +Vida" + precio,BLUE.corazon)

func animacion_monedas():
	var posicion_mondea = get_local_mouse_position()
	var monedas         = preload("res://moneda_particula/Moneda_particula.tscn").instance()
	monedas.position = posicion_mondea
	add_child(monedas)
	



#Si alguno cumple la condicion, compra, y agrega el nombre de la habilidad en un lista de GlobalVariables
func compra_base_panel():
	if _get_selected_item()   == 0: 
		GlobalVariables.Patk_speed *= 0.9
		music_compra_and_animation()
	elif _get_selected_item() == 1: 
			GlobalVariables.add_habilidad_Red("Speed")
			music_compra_and_animation()
	elif _get_selected_item() == 2: 
			GlobalVariables.add_habilidad_Red("damage")
			music_compra_and_animation()
	elif _get_selected_item() == 3:
			GlobalVariables.add_habilidad_Green("shield")
			music_compra_and_animation()

func comprar_red_panel():
	if _get_selected_item()   == 0: 
			GlobalVariables.add_habilidad_Red("Cuchillo")
			music_compra_and_animation()
	elif _get_selected_item() == 1: 
			GlobalVariables.add_habilidad_Red("damage_1")
			music_compra_and_animation()
	elif _get_selected_item()   == 2: 
			GlobalVariables.add_habilidad_Red("atk_speed")
			music_compra_and_animation()


func comprar_green_panel():
	if _get_selected_item() == 0: 
		GlobalVariables.habilidades.append("dash")
		music_compra_and_animation()



func comprar_blue_panel():
	if _get_selected_item() == 0:
		GlobalVariables.add_habilidad_Blue("Corazon")
		music_compra_and_animation()


func music_compra_and_animation():
	animacion_monedas()
	music_moneda_play()





func music_moneda_play():
	get_parent().get_node("music_moneda").play() 
	$Timer.set_wait_time(2)
	$Timer.start()
	
	
	
func music_moneda_stop():
	get_parent().get_node("music_moneda").stop()
	
func _get_selected_item()->int:
	return get_selected_items()[0]


func _on_Timer_timeout():
	music_moneda_stop()







func _on_upgrade_list_item_activated(index):
			#GlobalVariables.money >= intPrecio
	if true:
		GlobalVariables.money -= intPrecio
		get_parent().get_node("Coins").on_update()
		if parent_name == "BasePanel":
			compra_base_panel()
		elif parent_name == "RedPanel":
			comprar_red_panel()
		elif parent_name == "GreenPanel":
			comprar_green_panel()
		elif parent_name == "BluePanel":
			comprar_blue_panel()
