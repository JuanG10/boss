extends "res://state_machine/state.gd"

var player
var enemy
var target = Vector2.ZERO
var velocity = Vector2.ZERO
var friction
var speed

func initialize(p, e):
	player = p
	enemy = e
	friction = enemy.friction
	speed = enemy.speed

func update(_delta):
	if not enemy.is_stunned:
		target = player.global_position - enemy.global_position
		velocity += target
		velocity *= friction
		enemy.look_at(player.global_position)
		enemy.move_and_slide(velocity.normalized() * enemy.speed)
	if enemy.minimun_range_flag:
		if enemy.special == "special_red":
			emit_signal("finished", "special_red")
		else:
			emit_signal("finished", "minimun_range")
