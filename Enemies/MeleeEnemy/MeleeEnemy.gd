extends KinematicBody2D

var player
var speed = 130
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var dmg = 15
var health = 25

var special
var charge_flag = false

var colores     = [Color(0.0627, 0.102, 0.451),Color(0.551, 0.1582, 0.041),Color(0.251, 0.051, 0.0431)]
var collisiones = [0b100000001, 0b100000010, 0b100000100]
var specials    = ["special_blue", "special_orange", "special_red"]

var explosion_color:Color

func _ready():
	$State_handler.init(player, self)

func initialize(t, n):
	player = t
	$Sprite.modulate = colores[n]
	explosion_color = colores[n]
	collision_layer = collisiones[n]
	collision_mask  = collisiones[n]
	special = specials[n]
	if special == "special_orange" and GlobalVariables.retry == true:
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


func _on_area_entered(area):
	if area.filename == "res://Player/Bullet.tscn":
		if area.burn:
			burn()
		takeDamage(player.dmg)
		area.remove()
	if area.name == player.name: 
		player.takeDamage()


func _on_death():
	_create_explosion()
	
	get_parent().points += 10
	var c = GlobalVariables.coin.instance()
	c.initialize(position)
	get_parent().call_deferred("add_child", c)

func close_enough(_area):
	charge_flag = true

func far_enough(_area):
	charge_flag = false

func _create_explosion():
	var explosion = GlobalVariables.EXPLOSION.instance()
	explosion.position = position
	explosion.get_child(0).process_material.color_ramp.gradient.colors[1] = explosion_color
	explosion.get_child(0).emitting = true
	get_parent().call_deferred("add_child", explosion)
