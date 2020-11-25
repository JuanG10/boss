extends Area2D

var Bullet = preload("res://Player/Bullet.tscn")
const DMG_TEXT = preload("res://Fonts/FloatingText.tscn")
onready var label = $HUD/HP
onready var coins = $HUD/Coins 
onready var hability_bar = $HabilityCircleBar

var speed         = GlobalVariables.Pspeed     		#Naranja, velocidad de movimiento
var atk_speed     = GlobalVariables.Patk_speed 		#Azul, velocidad de ataque
var health        = GlobalVariables.Phealth    		#Azul, vida
var dmg           = GlobalVariables.Pdmg       		#Rojo, daño
var magnet_radius = GlobalVariables.magnet_radius 	#De todos los colores
var brn_dmg       = GlobalVariables.brn_dmg  		#Rojo, quemado de fuego
var heal_speed    = GlobalVariables.heal_speed 		#Azul, velocidad de curacion
var shield_speed  = GlobalVariables.shield_speed 	#Azul, escudo
var color_gris  = Color(0.345098,0.329412,0.329412,1)

var invencibility         = false
var speed_bullet          = 5

var shootT  = Timer.new()
var healT   = Timer.new()
var shieldT = Timer.new()
var isShielded = false

var habilityT = Timer.new()
var dash_use  = Timer.new()

#Blue, Orange and Red
var colores     = [Color(.0627, .1255, .702), Color(.9, .56, .0), Color(.702, .0823, .0706)]
var states
var pointer     = 0

onready var R = get_node("States/Red")
onready var O = get_node("States/Orange")
onready var B = get_node("States/Blue")

# Trap timers
var freezeT   = Timer.new()
var ralentizacion:float = 1
#var poison_dmg_timer = Timer.new()
var poisonT = Timer.new()
const POISONED_TIME = 3

var color_actual
onready var color_change_wait_time = Background.tiempo_transicion + 0.1

onready var limite_minimo_pantalla = get_tree().get_nodes_in_group("borde_minimo")[0].global_position
onready var limite_maximo_pantalla = get_tree().get_nodes_in_group("borde_maximo")[0].global_position

func _ready():
	label.on_update(health)
	states = [B, O, R]
	R.initialize(self)
	O.initialize(self)
	B.initialize(self)
	$Sprite.modulate = colores[pointer]
	color_actual     = colores[pointer]
	shootT.set_one_shot(true)
	shootT.set_wait_time(atk_speed)
	add_child(shootT)
	healT.set_one_shot(true)
	healT.set_wait_time(heal_speed)
	add_child(healT)
	shieldT.set_one_shot(true)
	shieldT.set_wait_time(shield_speed)
	add_child(shieldT)
	poisonT.set_one_shot(true)
	poisonT.set_wait_time(POISONED_TIME)
	poisonT.connect("timeout",self,"_on_poisonT_timeout")
	add_child(poisonT)
#	poison_dmg_timer.set_one_shot(false)
#	poison_dmg_timer.set_wait_time(1.5)
#	poison_dmg_timer.connect("timeout",self,"_on_poison_dmg_timeout")
#	add_child(poison_dmg_timer)
	freezeT.set_one_shot(true)
	freezeT.set_wait_time(2.5)
	freezeT.connect("timeout",self,"_on_freezeT_timeout")
	add_child(freezeT)
	habilityT.set_one_shot(true)
	habilityT.set_wait_time(10)
	add_child(habilityT)
	$Change_color_timer.set_wait_time(color_change_wait_time)

func _process(delta):
	_not_pass_frame_limit()

func recibi_danio():
	$Sprite.modulate = color_gris
	$Timer.set_wait_time(0.3)
	$Timer.start()
	

func volver_a_color_actual():
	$Sprite.modulate = color_actual 

func _on_Timer_timeout():
	volver_a_color_actual()
	
func _physics_process(_delta):

	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_accept") and habilityT.is_stopped():
		habilityT.start()
		hability_bar.start_progress(colores[pointer])
		color_actual = colores[pointer]
		states[pointer].power()
	if Input.is_action_just_pressed("next_color") && $Change_color_timer.is_stopped():
		$Change_color_timer.start()
		next_color()
		if not states[pointer].shield:
			remove_shield()
	if Input.is_action_just_pressed("previous_color") && $Change_color_timer.is_stopped():
		$Change_color_timer.start()
		previous_color()
		if not states[pointer].shield:
			remove_shield()
	if(states[pointer].shield and shieldT.is_stopped()):
		isShielded = true
		$Shield.show()
	if(states[pointer].heal and healT.is_stopped()):
		healT.start()
		heal(1)
	if(shootT.is_stopped()):
		shoot()
	_movimiento()
	if get_tree().current_scene.enemyCounter == 0 && !ManagerLevels.level_crossing:
		ManagerLevels.level_crossing = true

func _movimiento():
	if Input.is_action_pressed('right'):
		position.x += speed * ralentizacion
	if Input.is_action_pressed('left'):
		position.x -= speed * ralentizacion
	if Input.is_action_pressed('down'):
		position.y += speed * ralentizacion
	if Input.is_action_pressed('up'):
		position.y -= speed * ralentizacion

func _not_pass_frame_limit():
	# frame = marco de los bordes de la pantalla.
	if global_position.x < limite_minimo_pantalla.x:
		global_position.x = limite_minimo_pantalla.x + 2
	elif global_position.x > limite_maximo_pantalla.x:
		global_position.x = limite_maximo_pantalla.x - 2
	
	if global_position.y < limite_minimo_pantalla.y:
		global_position.y = limite_minimo_pantalla.y + 2
	elif global_position.y > limite_maximo_pantalla.y:
		global_position.y = limite_maximo_pantalla.y - 2

func heal(x):
	if(health + x > GlobalVariables.Phealth):
		health = GlobalVariables.Phealth
	else:
		health += x
	label.on_update(health)

func takeDamage(x):
	if not invencibility && get_tree().current_scene.enemyCounter != 0:
		if not isShielded:
			health -= x
			recibi_danio()
			set_last_score()
			label.on_update(health)
			shieldT.stop()
			shieldT.start()
			if health <= 0:
				LevelPrimitives.playing = false
				LevelPrimitives.retry = true
				var level_actual = get_tree().current_scene.level_id
				ManagerLevels.set_actual_level(level_actual)
				get_tree().change_scene("res://UpgradeScreen/UpgradeWindow.tscn")
		else:
			remove_shield()
			shieldT.start()
			

func set_last_score():
	if GlobalVariables.last_points < GlobalVariables.points:
		GlobalVariables.last_points = GlobalVariables.points

func remove_shield():
	isShielded = false
	$Shield.hide()

func shoot():
#	BulletHandler.add_bullet([$Muzzle.global_position, colores[pointer], rotation, self])
	var b = Bullet.instance()
	b.set_speed(speed_bullet)
	b.modulate = colores[pointer]
	b.start($Muzzle.global_position, rotation, dmg, pointer, states[pointer])
	get_parent().add_child(b)
	shootT.start(atk_speed)

func next_color():
	pointer = (pointer + 1)%3
	color_actual = colores[pointer]
	_change_with_color(pointer,true)

func previous_color():
	pointer = (pointer + 2)%3
	_change_with_color(pointer,false)

func stop_shooting(n):
	shootT.start(n)

func _on_grab_coin(area):
	area.grab()
	coins.on_update()

func _change_with_color(n:int,next:bool)->void:
	$Sprite.modulate = colores[n]
	hability_bar.tint_progress = colores[n]
	get_tree().get_nodes_in_group("labels")[0].change_outline(colores[n])
	Background.start_bg_transition(n, next, position.x, position.y)
	get_tree().current_scene.get_node("Complementos/Traps").change_trap_type(colores[n])

func on_enemy_entered(area):
	if area.is_in_group("Enemy"):
		takeDamage(area.dmg)

func update_score():
	$HUD/Score.set_text("Score: " + str(GlobalVariables.points))

############## RELACIONADO A LAS TRAMPAS ########################
func _on_freezeT_timeout():
	ralentizacion = 1

func start_poison_timers():
	$Sprite.modulate = Color(0,0.7,0.1) # Buscar un color mejor
	#poison_dmg_timer.start() # Descomentar para tener daño por veneno.
	poisonT.start()
	$Change_color_timer.start(POISONED_TIME) # Envenenado no puede cambiar de color

func _on_poison_dmg_timeout():
	takeDamage(1)

func _on_poisonT_timeout():
	$Change_color_timer.set_wait_time(color_change_wait_time)
	$Sprite.modulate = colores[pointer]
	#poison_dmg_timer.stop()
