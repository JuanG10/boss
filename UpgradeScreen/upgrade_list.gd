extends ItemList

onready var parent_name = get_parent().name
const ICON_SIZE = Vector2(100,100)

var DMGUpgCounter     = 0
var intPrecioDMG      = 30
var precioDMG         = "$" + str(intPrecioDMG)
var BRNUpgCounter     = 0
var intPrecioBRN      = 30
var precioBRN         = "$" + str(intPrecioBRN)
var SpeedUpgCounter   = 0
var intPrecioSpeed    = 100
var precioSpeed       = "$" + str(intPrecioSpeed)
var HPUpgCounter      = 0
var intPrecioHP       = 15
var precioHP          = "$" + str(intPrecioHP)
var AtkSUpgCounter    = 0
var intPrecioAtkS     = 80
var preciAtkS         = "$" + str(intPrecioAtkS)
var HealSUpgCounter   = 0
var intPrecioHealS    = 150
var preciHealS        = "$" + str(intPrecioHealS)
var ShieldSUpgCounter = 0
var intPrecioShieldS  = 70
var precioShieldS     = "$" + str(intPrecioShieldS)
var StunUpgCounter    = 0
var intPrecioStun     = 10
var preciStun         = "$" + str(intPrecioStun)
var InvTUpgCounter    = 0
var intPrecioInvT     = 90
var precioInvT        = "$" + str(intPrecioInvT)


# Iconos. Hardcodeado por ahora.
##Naranja
const ORANGE = {
	SPEED           = preload("res://Iconos/attack_speed.png"),          #Aumento de velocidad
	HEAL_SPEED      = preload("res://Iconos/HEAL_SPEED.jpg"),  #Velocidad de curacion
	HEALTH          = preload("res://Iconos/Paz_Mental.png"),  #Mejora de vida  
	INVULNERABILITY = null,
}
const BLUE = {
	PATK_SPEED   = preload("res://Iconos/meditation.png"),  #Velocidad de Ataque 
	SHIELD_SPEED = preload("res://Iconos/escudo.png"),       #mejora de escudo
	SLOWN        = null,
	SLOW_RING_EFFEC = null,
}

const RED = {
	DAMAGE      = preload("res://Iconos/DAMAGE.png"),  #Aumento de danio
	BRN_DAMAGE  = preload("res://Iconos/BRN_DAMAGE.png"),
	STUN        = null,
	LaserDMG    = null
}

var MONEDA = preload("res://moneda_particula/Moneda_particula.tscn").instance()



func _ready():
	set_fixed_icon_size(ICON_SIZE)
	if parent_name == "RedPanel":
		add_item("Damage: " + precioDMG, RED.DAMAGE)
		#add_item("BRN_DAMAGE: " + precioBRN, RED.BRN_DAMAGE)
		#add_item("STUN" + precio, RED.STUN)
		#add_item("Laser Damage: " + precio, RED.LaserDMG)
	elif parent_name == "GreenPanel":
		add_item( "Speed: " + precioSpeed, ORANGE.SPEED) #2
		add_item("Heal Speed: " + preciHealS, ORANGE.HEAL_SPEED)
		add_item("Health: " + precioHP, ORANGE.HEALTH)
		#add_item("Invulnerability Time: " + precioInvT, ORANGE.INVULNERABILITY)
	elif parent_name == "BluePanel":
		add_item("Patk Speed: " + preciAtkS, BLUE.PATK_SPEED)
		add_item("Shield Speed: " + precioShieldS, BLUE.SHIELD_SPEED)
		#add_item("SLOWN" + precio, BLUE.SLOWN)
		#add_item("SLOW_RING_EFFEC" + precio, BLUE.SLOW_RING_EFFEC)
		
func animacion_monedas():
	var posicion_mondea = get_local_mouse_position()
	var monedas         = preload("res://moneda_particula/Moneda_particula.tscn").instance()
	monedas.position = posicion_mondea
	add_child(monedas)


func comprar_red_panel():
	if _get_selected_item() == 0:
		Upgrades.dmgUpgrade()
		music_compra_and_animation() 
	elif _get_selected_item() == 1:
		GlobalVariables.brn_dmg += 5
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
	if GlobalVariables.money >= intPrecio:
		GlobalVariables.money -= intPrecio
		get_parent().get_node("Coins").on_update()
		if parent_name == "RedPanel":
			comprar_red_panel()
		elif parent_name == "GreenPanel":
			comprar_orange_panel()
		elif parent_name == "BluePanel":
			comprar_blue_panel()
