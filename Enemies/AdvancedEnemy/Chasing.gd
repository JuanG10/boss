extends "res://state_machine/state.gd"

var player
var enemy
var target = Vector2.ZERO
var friction

func initialize(p, e):
	player = p
	enemy = e
	friction = enemy.friction

func red_condition():
	return enemy.minimun_range_flag and enemy.tipo == 2

func flocking_condition():
	return enemy.get_node("FlockingArea").get_overlapping_areas().size() > 1

func blue_condition():
	return false

func update(delta):
	if red_condition() or blue_condition():
			emit_signal("finished", enemy.special)
	if flocking_condition():
			emit_signal("finished", "flocking")
	if enemy.minimun_range_flag:
			emit_signal("finished", "minimun_range")
	if not enemy.is_stunned:
		target = player.global_position - enemy.global_position
		enemy.velocity += target
		enemy.velocity *= friction
		enemy.velocity  = enemy.velocity.normalized()
		enemy.look_at(enemy.prediction)
		enemy.position += enemy.velocity * enemy.speed * delta
