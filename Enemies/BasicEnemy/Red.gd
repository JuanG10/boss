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
	#side_to_side()
	if not enemy.is_stunned:
		enemy.look_at(player.global_position)
	if not enemy.minimun_range_flag:
		emit_signal("finished", "chasing")

func side_to_side():
	var even_iteration = false
	target = player.global_position - enemy.global_position
	target = target.rotated(90)
	if even_iteration:
		target = target.rotated(-90)
	velocity += target
	velocity *= friction
	enemy.move_and_slide(velocity.normalized() * speed)
	even_iteration = not even_iteration

func enter():
	enemy.atk_speed = .6

func exit():
	enemy.atk_speed = .8
