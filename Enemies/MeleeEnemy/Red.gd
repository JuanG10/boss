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
	print("charge initialized")
	target = player.global_position - enemy.global_position
	velocity += target
	velocity *= friction
	enemy.look_at(player.global_position)
	enemy.move_and_slide(velocity.normalized() * speed * 2)
	if not enemy.charge_flag:
		emit_signal("finished", "chasing")
