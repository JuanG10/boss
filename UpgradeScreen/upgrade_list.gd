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
	pistola = preload("res://Iconos/pistola_base.png"),
	explosion = preload("res://Iconos/explosion.jpg")
}
##Naranja
const ORANGE = {
	cuchillo = preload("res://Iconos/cuchillo_azul-violeta.png"),
	escudo = preload("res://Iconos/defensa_base.png"),
	pistola = preload("res://Iconos/pistola_azul-violeta.png"),
	dash    = preload("res://Iconos/relampago.png")
}
const BLUE = {
	attack_speed = preload("res://Iconos/attack_speed.png")
}

var MONEDA = preload("res://moneda_particula/Moneda_particula.tscn").instance()



func _ready():
	set_fixed_icon_size(ICON_SIZE)
	if parent_name == "RedPanel":
		add_item("Disparo explosivo " + precio, BASE.explosion)
	elif parent_name == "GreenPanel":
		add_item("Dash " + precio, ORANGE.dash) #2
	elif parent_name == "BluePanel":
		add_item("Attack_speed " + precio, BLUE.attack_speed)

func animacion_monedas():
	var posicion_mondea = get_local_mouse_position()
	var monedas         = preload("res://moneda_particula/Moneda_particula.tscn").instance()
	monedas.position = posicion_mondea
	add_child(monedas)
	



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
	if _get_selected_item() == 0:
		GlobalVariables.Pdmg  +=5
		music_compra_and_animation()
	elif _get_selected_item() == 1:
		GlobalVariables.brn_dmg +=1
		music_compra_and_animation() 

func comprar_orange_panel():
	if _get_selected_item() == 0: 
		GlobalVariables.Pspeed += 1
		music_compra_and_animation()



func comprar_blue_panel():
	if _get_selected_item() == 0:
		GlobalVariables.heal_speed -= 0.5
		music_compra_and_animation()
	elif _get_selected_item() == 1:
		GlobalVariables.shield_speed -= 1
		music_compra_and_animation()
	elif _get_selected_item() == 2:
		GlobalVariables.Phealth += 20
		music_compra_and_animation()
	elif _get_selected_item() == 3:
		GlobalVariables.Patk_speed -= 0.1 
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
	if GlobalVariables.money >= intPrecio:
		GlobalVariables.money -= intPrecio
		get_parent().get_node("Coins").on_update()
		if parent_name == "RedPanel":
			comprar_red_panel()
		elif parent_name == "GreenPanel":
			comprar_orange_panel()
		elif parent_name == "BluePanel":
			comprar_blue_panel()
