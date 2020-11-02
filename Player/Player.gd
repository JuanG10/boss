extends Area2D

var Bullet = preload("res://Bullet.tscn") 

var speed = 3
var atk_speed = .5
var health = 100
var dmg = 10
var magnet_radius = 10

var timer = Timer.new()

func _ready():
	timer.set_one_shot(true)
	timer.set_wait_time(atk_speed)
	add_child(timer)

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	#if Input.is_action_just_pressed("ui_accept"):
	#	speed *= 3
	#if Input.is_action_just_released("ui_accept"):
	#	speed /= 3
	if Input.is_action_just_pressed("next_color"):
		collision_layer = 2
		collision_mask  = 2
		$Sprite.modulate = Color(0, 0, 1) # blue shade
	if Input.is_action_pressed("ui_accept"):
		if(timer.is_stopped()):
			shoot()
	if Input.is_action_pressed('ui_right'):
		position.x += speed
	if Input.is_action_pressed('ui_left'):
		position.x -= speed
	if Input.is_action_pressed('ui_down'):
		position.y += speed
	if Input.is_action_pressed('ui_up'):
		position.y -= speed


func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)
	timer.start()
