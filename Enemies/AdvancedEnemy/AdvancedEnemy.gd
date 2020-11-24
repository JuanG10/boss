extends Area2D

var player
var speed = 40
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var slow_timer = Timer.new()
var stun_timer = Timer.new()
var is_stunned = false

var health = 70
var dmg = 10
var atk_speed = .4

var special
var minimun_range_flag = false

var timer = Timer.new()

var Bullet = preload("res://Enemies/Bullet.tscn")

var colores     = [Color(0.0627, 0.102, 0.451),Color(0.551, 0.1582, 0.041),Color(0.251, 0.051, 0.0431)]
var specials    = ["special_blue", "special_orange", "special_red"]
var tipo

var explosion_color:Color

func _ready():
	$State_handler.init(player, self)
	timer.set_one_shot(true)
	stun_timer.set_one_shot(true)
	slow_timer.set_one_shot(true)
	add_child(stun_timer)
	add_child(slow_timer)
	add_child(timer)

#acá habría que agregar el color y las colisiones
func initialize(t, n):
	player = t
	$Sprite.modulate = colores[n]
	explosion_color = colores[n]
	tipo = n
	special = specials[n]
	if special == "special_orange" and GlobalVariables.retry == true:
		GlobalVariables.Admg *= 1.1
		GlobalVariables.Ahealth *= 1.1
		dmg = GlobalVariables.Admg
		health = GlobalVariables.Ahealth

func close_enough(area):
	if area.name == player.name:
		minimun_range_flag = true

func far_enough(area):
	if area.name == player.name:
		minimun_range_flag = false

func burn():
	for _i in range(10):
		takeDamage(player.brn_dmg)
		yield(get_tree().create_timer(.1), "timeout")

func stun(time):
	stun_timer.start(time)
	is_stunned = true

func slow(slow, time):
	if slow_timer.is_stopped():
		slow_timer.start(time)
		speed *= slow

func _process(_delta):
	if stun_timer.is_stopped():
		is_stunned = false
	if slow_timer.is_stopped():
		speed = 130
	if(timer.is_stopped() and not is_stunned):
		shoot()

func takeDamage(n):
	health -= n
	if health <= 0:
		get_parent().call_deferred("remove_child", self)
		queue_free()

func _on_death():
	_create_explosion()
	GlobalVariables.points += 200
	get_tree().current_scene.update_score()
	for i in range(3):
		var c = GlobalVariables.coin.instance()
		c.initialize(position + Vector2(rand_range(0, i*10),rand_range(0, i*10)))
		get_parent().call_deferred("add_child", c)

func _create_explosion():
	var explosion = GlobalVariables.EXPLOSION.instance()
	explosion.position = position
	explosion.get_child(0).process_material.color_ramp.gradient.colors[1] = explosion_color
	explosion.get_child(0).emitting = true
	get_parent().call_deferred("add_child", explosion)

func shoot():
	for _i in range(3):
		var b = Bullet.instance()
		b.start($Muzzle.global_position, rotation, player, dmg, tipo)
		get_parent().add_child(b)
		yield(get_tree().create_timer(.02), "timeout")
	timer.start(atk_speed)
