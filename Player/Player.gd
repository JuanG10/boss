extends Area2D

var Bullet = preload("res://Player/Bullet.tscn") 
var label
var coins  

var speed         = GlobalVariables.speed
var atk_speed     = GlobalVariables.atk_speed
var health        = GlobalVariables.health
var dmg           = GlobalVariables.dmg
var magnet_radius = GlobalVariables.magnet_radius
var brn_dmg       = GlobalVariables.brn_dmg
var heal_speed    = GlobalVariables.heal_speed
var shield_speed  = GlobalVariables.shield_speed



var shootT  = Timer.new()
var healT   = Timer.new()
var shieldT = Timer.new()
var isShielded = false

var colores     = [Color(0,0,1),Color(0,1,0),Color(1,0,0)]
var collisiones = [0b110, 0b101, 0b011]
var states
var n           = 0

onready var R = get_node("States/Red")
onready var G = get_node("States/Green")
onready var B = get_node("States/Blue")

var habilidades = GlobalVariables.habilidadres

var puedo_activar = false


func initialize(l,c):
	label = l
	coins = c
	label.on_update(health)
	states = [B, G, R]

func _ready():
	$Sprite.modulate = colores[n]
	collision_layer = collisiones[n]
	collision_mask  = collisiones[n]
	shootT.set_one_shot(true)
	shootT.set_wait_time(atk_speed)
	add_child(shootT)
	healT.set_one_shot(true)
	healT.set_wait_time(heal_speed)
	add_child(healT)
	shieldT.set_one_shot(true)
	shieldT.set_wait_time(shield_speed)
	add_child(shieldT)

func _physics_process(_delta):
	#print(habilidad)
	look_at(get_global_mouse_position())
	#if Input.is_action_just_pressed("ui_accept"):
	#	speed *= 3
	#if Input.is_action_just_released("ui_accept"):
	#	speed /= 3
	if Input.is_action_just_pressed("ui_accept"):
		print($States/Blue.burn)
	if Input.is_action_just_pressed("next_color"):
		next_color()
		if not states[n].shield:
			remove_shield()
		collision_layer = collisiones[n]
		collision_mask  = collisiones[n]
	if Input.is_action_just_pressed("previous_color"):
		previous_color()
		if not states[n].shield:
			remove_shield()
		collision_layer = collisiones[n]
		collision_mask  = collisiones[n]
	if(states[n].shield and shieldT.is_stopped()):
		isShielded = true
		$Shield.show()
	if(states[n].heal and healT.is_stopped()):
		healT.start()
		heal(1)
	#if(shootT.is_stopped()):
	#	shoot()
	if Input.is_action_pressed('right'):
		position.x += speed
	if Input.is_action_pressed('left'):
		position.x -= speed
	if Input.is_action_pressed('down'):
		position.y += speed
	if Input.is_action_pressed('up'):
		position.y -= speed
		
	if Input.is_action_just_pressed("Activate_shield") && existe_habilidad("shield"):
		GlobalVariables.health *= 1.1
		health = GlobalVariables.health
		label.on_update(health)
	if Input.is_action_just_pressed("Activate_speed") && existe_habilidad("speed"):
		GlobalVariables.speed += .5
		speed = GlobalVariables.speed
	if Input.is_action_just_pressed("Activate_damage") && existe_habilidad("damage"):
		GlobalVariables.dmg += 1
		dmg = GlobalVariables.dmg
	if Input.is_action_just_pressed("Activate_atk_speed") && existe_habilidad("atk_speed"):
		GlobalVariables.atk_speed *= 0.9
		atk_speed = GlobalVariables.atk_speed	
		
			

func existe_habilidad(nombre_habilidad):
	var boolean = false 
	for name_habilidad in GlobalVariables.habilidadres:
		boolean = nombre_habilidad == name_habilidad
	return boolean	


func heal(x):
	if(health + x > GlobalVariables.health):
		health = GlobalVariables.health
	else:
		health += x
	label.on_update(health)

func takeDamage(x):
	if not isShielded:
		health -= x
		label.on_update(health)
		if health <= 0:
			get_tree().change_scene("res://UpgradeScreen/UpgradeWindow.tscn")
	else:
		remove_shield()
		shieldT.start()

func remove_shield():
	isShielded = false
	$Shield.hide()

func shoot():
	var b = Bullet.instance()
	b.modulate        = colores[n]
	b.collision_layer = collisiones[n]
	b.collision_mask  = collisiones[n]
	b.start($Muzzle.global_position, rotation, dmg, states[n].burn)
	get_parent().add_child(b)
	shootT.start()

func next_color():
	n = (n + 1)%3
	$Sprite.modulate = colores[n]
	
func previous_color():
	n = (n + 2)%3
	$Sprite.modulate = colores[n] 

func _on_grab_coin(area):
	area.grab()
	coins.on_update()

func puede_activar_habilidad():
	 puedo_activar = true 

func _on_Timer_timeout():
	pass 








