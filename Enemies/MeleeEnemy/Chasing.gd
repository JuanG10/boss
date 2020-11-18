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

func red_condition():
	return enemy.charge_flag and enemy.tipo == 2

func blue_condition():
	return enemy.get_node("ChargeRange").get_overlapping_bodies().size() > 0 and enemy.tipo == 0

func update(_delta):
	if not enemy.is_stunned:
		target = player.global_position - enemy.global_position
		velocity += target
		velocity *= friction
		enemy.look_at(player.global_position)
		enemy.move_and_slide(velocity.normalized() * enemy.speed)
	if red_condition() or blue_condition():
		emit_signal("finished", enemy.special)
