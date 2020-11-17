extends "res://state_machine/state.gd"

var player
var enemy
var target = Vector2.ZERO
var velocity = Vector2.ZERO
var friction


func initialize(p, e):
	player = p
	enemy = e
	friction = enemy.friction

func update(delta):
	if not enemy.is_stunned:
		target = player.global_position - enemy.global_position
		velocity += target
		velocity *= friction
		enemy.look_at(player.global_position)
		enemy.move_and_slide(velocity.normalized() * enemy.speed)
	if enemy.charge_flag:
		emit_signal("finished", enemy.special)
