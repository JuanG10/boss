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

var habilidad_health 	= true 
var habilidad_speed  	= true
var habilidad_atk_speed = true 
var habilidad_damage    = true
var habilidad_corazon   = true

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
	
func color_actual():
	var sprite_modulate = $Sprite.modulate
	if sprite_modulate == Color(1,0,0,1):
		return "Red"
	elif sprite_modulate == Color(0,0,1,1):
		return "Blue"
	elif sprite_modulate == Color(0,1,0,1):
		return "Green"
	
func add_habiliad_state(name_habilidad,color_player):
	$States.get_node(color_player).add_habilidad(name_habilidad)
				
		
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
	
	#Si tiene la habiladad la usa	
	if Input.is_action_just_pressed("Activate_shield") && existe_habilidad("shield") && habilidad_health && color_actual() == "Verde":
		efecto_de_health()
		activar_timer()	
	if Input.is_action_just_released("Activate_corazon") && existe_habilidad("Corazon") && habilidad_corazon && color_actual() == "Blue":
		efecto_de_corazon()
		activar_timer()
			
	if Input.is_action_just_pressed("Activate_speed") && existe_habilidad("speed") && habilidad_speed:
		efecto_de_speed()
		activar_timer()
	if Input.is_action_just_pressed("Activate_damage") && existe_habilidad("damage") && habilidad_damage:
		efecto_de_damage()
		activar_timer()
	if Input.is_action_just_pressed("Activate_atk_speed") && existe_habilidad("atk_speed") && habilidad_atk_speed:
		efecto_de_atk_speed()
		activar_timer()	
		

func efecto_de_corazon():
	GlobalVariables.health += 30
	health = GlobalVariables.health
	label.on_update(health)
	habilidad_corazon = false

#El personaje recupera vida
func efecto_de_health():
	GlobalVariables.health *= 1.1
	health = GlobalVariables.health
	label.on_update(health)
	habilidad_health = false	

#La velocidad del personaje aumenta
func efecto_de_speed():
	GlobalVariables.speed += .5
	speed = GlobalVariables.speed
	habilidad_speed = false
	
#El daño del personaje aumenta en 1
func efecto_de_damage():
	GlobalVariables.dmg += 1
	dmg = GlobalVariables.dmg
	habilidad_damage = false
	
	
#La velocidad de ataque del personaje aumenta	
func efecto_de_atk_speed():
	GlobalVariables.atk_speed *= 0.9
	atk_speed = GlobalVariables.atk_speed
	habilidad_atk_speed = false
	
	
func activar_timer():
	$Timer.set_wait_time(5)
	$Timer.start()
		


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

func active_health():
	 habilidad_health = true 
	 $Timer.stop()

func active_speed():
	habilidad_speed = true
	$Timer.stop()
	
func active_atk_speed():
	habilidad_atk_speed = true 
	$Timer.stop()
	
func active_damage():
	habilidad_damage = true
	$Timer.stop()			

func _on_Timer_timeout():
	if !habilidad_health:
		active_health() 








