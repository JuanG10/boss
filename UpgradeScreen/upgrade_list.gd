extends ItemList

onready var parent_name = get_parent().name
const ICON_SIZE = Vector2(100,100)

# Iconos. Hardcodeado por ahora.
##Naranja
const ORANGE = {
	SPEED           = preload("res://Iconos/speed.png"),          #Aumento de velocidad
	HEAL_SPEED      = preload("res://Iconos/HEAL_SPEED.jpg"),  #Velocidad de curacion
	HEALTH          = preload("res://Iconos/health.png"),  #Mejora de vida  
	INVULNERABILITY = preload("res://Iconos/invulnerability.png"),
}
const BLUE = {
	PATK_SPEED   = preload("res://Iconos/attack_speed.png"),  #Velocidad de Ataque 
	SHIELD_SPEED = preload("res://Iconos/escudo.png"),       #mejora de escudo
	SLOW         = preload("res://Iconos/slow.png"),
	SLOW_RING_EFFEC = preload("res://Iconos/Slow_ring.png"),
}

const RED = {
	DAMAGE      = preload("res://Iconos/DAMAGE.png"),  #Aumento de danio
	BRN_DAMAGE  = preload("res://Iconos/BRN_DAMAGE.png"),
	STUN        = preload("res://Iconos/stun.png"),
	LaserDMG    = preload("res://Iconos/laser.jpg")
}

var MONEDA = preload("res://moneda_particula/Moneda_particula.tscn").instance()



func _ready():
	set_fixed_icon_size(ICON_SIZE)
	if parent_name == "RedPanel":
		add_item("Damage: " + Upgrades.precioDMG, RED.DAMAGE)
		#add_item("BRN_DAMAGE: " + precioBRN, RED.BRN_DAMAGE)
		add_item("Stun Duration: " + Upgrades.precioStun, RED.STUN)
		add_item("Activate Laser: " + Upgrades.precioLaser, RED.LaserDMG)
	elif parent_name == "GreenPanel":
		add_item("Speed: " + Upgrades.precioSpeed, ORANGE.SPEED) #2
		add_item("Heal Speed: " + Upgrades.precioHealS, ORANGE.HEAL_SPEED)
		add_item("Health: " + Upgrades.precioHP, ORANGE.HEALTH)
		add_item("Activate Invulnerability: " + Upgrades.precioInvT, ORANGE.INVULNERABILITY)
	elif parent_name == "BluePanel":
		add_item("Atack Speed: " + Upgrades.precioAtkS, BLUE.PATK_SPEED)
		add_item("Shield Speed: " + Upgrades.precioShieldS, BLUE.SHIELD_SPEED)
		add_item("Slow: " + Upgrades.precioSlow, BLUE.SLOW)
		add_item("Activate Slow Ring: " + Upgrades.precioSlowRing, BLUE.SLOW_RING_EFFEC)
		
func animacion_monedas():
	var posicion_mondea = get_local_mouse_position()
	var monedas         = preload("res://moneda_particula/Moneda_particula.tscn").instance()
	monedas.position = posicion_mondea
	add_child(monedas)


func comprar_red_panel():
	if _get_selected_item() == 0:
		Upgrades.dmgUpgrade(self)
		music_compra_and_animation() 
	elif _get_selected_item() == 1:
		Upgrades.stunUpgrade(self)
		music_compra_and_animation()
	elif _get_selected_item() == 2:
		Upgrades.laserUpgrade(self)
		music_compra_and_animation()

func comprar_orange_panel():
	if _get_selected_item() == 0: 
		Upgrades.speedUpgrade(self)
		music_compra_and_animation()
	elif _get_selected_item() == 1:
		Upgrades.healUpgrade(self)
		music_compra_and_animation()
	elif _get_selected_item() == 2:
		Upgrades.HPUpgrade(self)
		music_compra_and_animation()
	elif _get_selected_item() == 3:
		Upgrades.InvuleravilityUpgrade(self)
		music_compra_and_animation()

func comprar_blue_panel():
	if _get_selected_item() == 0:
		Upgrades.atkSpeedUpgrade(self)
		music_compra_and_animation()
	elif _get_selected_item() == 1:
		Upgrades.shieldUpgrade(self)
		music_compra_and_animation()
	elif _get_selected_item() == 2:
		Upgrades.slowUpgrade(self)
		music_compra_and_animation()
	elif _get_selected_item() == 3:
		Upgrades.slowRingUpgrade(self)
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
	if parent_name == "RedPanel":
		if _get_selected_item() == 0:
			if GlobalVariables.money >= Upgrades.intPrecioDMG:
				GlobalVariables.money -= Upgrades.intPrecioDMG
				comprar_red_panel()
		if _get_selected_item() == 1:
			if GlobalVariables.money >= Upgrades.intPrecioStun:
				GlobalVariables.money -= Upgrades.intPrecioStun
				comprar_red_panel()
		if _get_selected_item() == 2:
			if GlobalVariables.money >= Upgrades.intPrecioLaser:
				GlobalVariables.money -= Upgrades.intPrecioLaser
				comprar_red_panel()
	elif parent_name == "GreenPanel":
		if _get_selected_item() == 0:
			if GlobalVariables.money >= Upgrades.intPrecioSpeed:
				GlobalVariables.money -= Upgrades.intPrecioSpeed
				comprar_orange_panel()
		if _get_selected_item() == 1:
			if GlobalVariables.money >= Upgrades.intPrecioHealS:
				GlobalVariables.money -= Upgrades.intPrecioHealS
				comprar_orange_panel()
		if _get_selected_item() == 2:
			if GlobalVariables.money >= Upgrades.intPrecioHP:
				GlobalVariables.money -= Upgrades.intPrecioHP
				comprar_orange_panel()
		if _get_selected_item() == 3:
			if GlobalVariables.money >= Upgrades.intPrecioInvT:
				GlobalVariables.money -= Upgrades.intPrecioInvT
				comprar_orange_panel()
	elif parent_name == "BluePanel":
		if _get_selected_item() == 0:
			if GlobalVariables.money >= Upgrades.intPrecioAtkS:
				GlobalVariables.money -= Upgrades.intPrecioAtkS
				comprar_blue_panel()
		if _get_selected_item() == 1:
			if GlobalVariables.money >= Upgrades.intPrecioShieldS:
				GlobalVariables.money -= Upgrades.intPrecioShieldS
				comprar_blue_panel()
		if _get_selected_item() == 2:
			if GlobalVariables.money >= Upgrades.intPrecioSlow:
				GlobalVariables.money -= Upgrades.intPrecioSlow
				comprar_blue_panel()
		if _get_selected_item() == 3:
			if GlobalVariables.money >= Upgrades.intPrecioSlowRing:
				GlobalVariables.money -= Upgrades.intPrecioSlowRing
				comprar_blue_panel()
	get_parent().get_node("Coins").on_update()
