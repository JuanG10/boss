extends Area2D

var Bullet = preload("res://Player/Bullet.tscn") 

var speed = 3
var atk_speed = .5
var health = 100
var dmg = 10
var magnet_radius = 10

var timer = Timer.new()

var colores = [Color(0, 0, 1),Color(0,1,0),Color(1,0,0),Color(0.937255,0.796078,0.031373)]
var n      = 0
var color_activado = false



func _ready():
	timer.set_one_shot(true)
	timer.set_wait_time(atk_speed)
	add_child(timer)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(_delta):
	look_at(get_global_mouse_position())
	#if Input.is_action_just_pressed("ui_accept"):
	#	speed *= 3
	#if Input.is_action_just_released("ui_accept"):
	#	speed /= 3
	if Input.is_action_just_pressed("next_color"):
		collision_layer = 2
		collision_mask  = 2
		next_color() # blue shade
	if Input.is_action_just_pressed("previous_color"):
		previous_color()		
	#if Input.is_action_pressed("shoot"):
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
	if health <= 0:
		get_tree().reload_current_scene()

func shoot():
	var b = Bullet.instance()
	if(color_activado):
		b.modulate = colores[n-1]
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)
	timer.start()
	
	
func modulate_color():
	 return $Sprite.modulate
	
	
func next_color():
	if(n < colores.size()):
		$Sprite.modulate = colores[n]
		n = n +1
	else:
		n = 0
		$Sprite.modulate = colores[n]
		n = n + 1	  
	color_activado = true	
	
func previous_color():
	if(n >= 0):
		n = n - 1
		$Sprite.modulate = colores[n-1] 
	else:
		n = 3
		$Sprite.modulate = colores[n]
		n = n -1
	color_activado = true			
