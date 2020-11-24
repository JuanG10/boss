extends Area2D

var player
var speed = 130
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var slow_timer = Timer.new()
var stun_timer = Timer.new()
var is_stunned = false

var dmg = 15
var health = 25

var special
var charge_flag = false

var colores     = [Color(0.0627, 0.102, 0.451),Color(0.551, 0.1582, 0.041),Color(0.251, 0.051, 0.0431)]
var specials    = ["special_blue", "special_orange", "special_red"]
var tipo

var explosion_color:Color

func _ready():
	$State_handler.init(player, self)
	stun_timer.set_one_shot(true)
	slow_timer.set_one_shot(true)
	add_child(stun_timer)
	add_child(slow_timer)

func _process(_delta):
	if stun_timer.is_stopped():
		is_stunned = false
	if slow_timer.is_stopped():
		speed = 130

func initialize(t, n):
	player = t
	tipo = n
	$Sprite.modulate = colores[n]
	explosion_color = colores[n]
	special = specials[n]
	if special == "special_orange" and LevelPrimitives.retry == true:
		GlobalVariables.Mdmg *= 1.1
		GlobalVariables.Mhealth *= 1.1
		dmg = GlobalVariables.Mdmg
		health = GlobalVariables.Mhealth

func takeDamage(n):
	health -= n
	if health <= 0:
		get_parent().call_deferred("remove_child", self)
		queue_free()

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

func _on_death():
	_create_explosion()
	#get_parent().points += 10
	get_parent().enemyCounter -= 1
	var c = GlobalVariables.coin.instance()
	c.initialize(position)
	get_parent().call_deferred("add_child", c)

func close_enough(area):
	if area.name == player.name:
		charge_flag = true

func far_enough(area):
	if area.name == player.name:
		charge_flag = false

func _create_explosion():
	var explosion = GlobalVariables.EXPLOSION.instance()
	explosion.position = position
	explosion.get_child(0).process_material.color_ramp.gradient.colors[1] = explosion_color
	explosion.get_child(0).emitting = true
	get_parent().call_deferred("add_child", explosion)
