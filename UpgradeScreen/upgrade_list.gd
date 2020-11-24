extends ItemList

onready var parent_name = get_parent().name
const ICON_SIZE = Vector2(100,100)

const intPrecio = 30
const precio = "$" + str(intPrecio) # Debería ir incrementando.

# Iconos. Hardcodeado por ahora.
##Naranja
const ORANGE = {
	SPEED =   preload("res://Iconos/attack_speed.png")          #Aumento de velocidad
}
const BLUE = {
	PATK_SPEED   = preload("res://Iconos/meditation.png"),  #Velocidad de Ataque 
	HEALTH       = preload("res://Iconos/Paz_Mental.png"),  #Mejora de vida  
	HEAL_SPEED   = preload("res://Iconos/HEAL_SPEED.jpg"),  #Velocidad de curacion                              
	SHIELD_SPEED = preload("res://Iconos/escudo.png"),       #mejora de escudo
	SLOWN        = null,
	SLOW_RING_EFFEC = null,
}

const RED = {
	DAMAGE    	= preload("res://Iconos/DAMAGE.png"),  #Aumento de danio
	BRN_DAMAGE	= preload("res://Iconos/BRN_DAMAGE.png"),
	STUN        = null,
	BFdmg       = null
}

var MONEDA = preload("res://moneda_particula/Moneda_particula.tscn").instance()



func _ready():
	set_fixed_icon_size(ICON_SIZE)
	if parent_name == "RedPanel":
		add_item("Damage " + precio, RED.DAMAGE)
		add_item("BRN_DAMAGE " + precio,RED.BRN_DAMAGE)
		#add_item("STUN" + precio, RED.STUN)
		#add_item("BFDMG" + precio, RED.BFdmg)
	elif parent_name == "GreenPanel":
		add_item( "Speed " + precio, ORANGE.SPEED) #2		
	elif parent_name == "BluePanel":
		add_item("Health " + precio, BLUE.HEALTH)
		add_item("Patk Speed " + precio, BLUE.PATK_SPEED)
		add_item("Heal Speed " + precio, BLUE.HEAL_SPEED)
		add_item("Shield Speed " + precio, BLUE.SHIELD_SPEED)
		#add_item("SLOWN" + precio, BLUE.SLOWN)
		#add_item("SLOW_RING_EFFEC" + precio, BLUE.SLOW_RING_EFFEC)
		
func animacion_monedas():
	var posicion_mondea = get_local_mouse_position()
	var monedas         = preload("res://moneda_particula/Moneda_particula.tscn").instance()
	monedas.position = posicion_mondea
	add_child(monedas)


func comprar_red_panel():
	if _get_selected_item() == 0:
		GlobalVariables.Pdmg  +=5
		music_compra_and_animation() 

func comprar_orange_panel():
	if _get_selected_item() == 0: 
		GlobalVariables.Pspeed += 1
		music_compra_and_animation()

func comprar_blue_panel():
	if _get_selected_item() == 0:
		GlobalVariables.Phealth += 20
		music_compra_and_animation()
	elif _get_selected_item() == 1:
		GlobalVariables.Patk_speed -= 0.1 
		music_compra_and_animation()	
	elif _get_selected_item() == 2:
		GlobalVariables.heal_speed -= 0.5
		music_compra_and_animation()
	elif _get_selected_item() == 3:
		GlobalVariables.shield_speed -= 1
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
		if parent_name == "RedPanel":
			comprar_red_panel()
		elif parent_name == "GreenPanel":
			comprar_orange_panel()
		elif parent_name == "BluePanel":
			comprar_blue_panel()
