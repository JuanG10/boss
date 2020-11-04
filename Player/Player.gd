extends Area2D

var Bullet = preload("res://Player/Bullet.tscn") 
var label
var coins

var speed = GlobalVariables.speed
var atk_speed = GlobalVariables.atk_speed
var health = GlobalVariables.health
var dmg = GlobalVariables.dmg
var magnet_radius = GlobalVariables.magnet_radius

var timer = Timer.new()

var colores = [Color(0, 0, 1),Color(0,1,0),Color(1,0,0)]
var collisiones = [0b110, 0b101, 0b011]
var n       = 0

func initialize(l,c):
	label = l
	coins = c
	label.on_update(health)

func _ready():
	$Sprite.modulate = colores[n]
	collision_layer = collisiones[n]
	collision_mask  = collisiones[n]
	timer.set_one_shot(true)
	timer.set_wait_time(atk_speed)
	add_child(timer)

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	#if Input.is_action_just_pressed("ui_accept"):
	#	speed *= 3
	#if Input.is_action_just_released("ui_accept"):
	#	speed /= 3
	if Input.is_action_just_pressed("ui_accept"):
		print(GlobalVariables.money)
	if Input.is_action_just_pressed("next_color"):
		next_color()
		collision_layer = collisiones[n]
		collision_mask  = collisiones[n]
	if Input.is_action_just_pressed("previous_color"):
		previous_color()
		collision_layer = collisiones[n]
		collision_mask  = collisiones[n]
	if(timer.is_stopped()):
		shoot()
	if Input.is_action_pressed('right'):
		position.x += speed
	if Input.is_action_pressed('left'):
		position.x -= speed
	if Input.is_action_pressed('down'):
		position.y += speed
	if Input.is_action_pressed('up'):
		position.y -= speed

func takeDamage(n):
	health -= n
	label.on_update(health)
	if health <= 0:
		get_tree().change_scene("res://UpgradeScreen/UpgradeWindow.tscn")

func shoot():
	var b = Bullet.instance()
	b.modulate = colores[n]
	b.start($Muzzle.global_position, rotation, dmg, collisiones[n])
	get_parent().add_child(b)
	timer.start()

func next_color():
	n = (n + 1)%3
	$Sprite.modulate = colores[n]
	
func previous_color():
	n = (n + 2)%3
	$Sprite.modulate = colores[n] 

func _on_grab_coin(area):
	area.grab()
	coins.on_update()
