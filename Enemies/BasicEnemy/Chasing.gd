extends "res://state_machine/state.gd"

var player
var enemy
var target = Vector2.ZERO
var velocity
var friction

func initialize(p, e):
	player = p
	enemy = e
	friction = enemy.friction
	velocity = enemy.velocity

#func enter():
#	print("hello")

#func exit():
#	print("bye")

func red_condition():
	return enemy.minimun_range_flag and enemy.tipo == 2

func blue_condition():
	return enemy.get_node("FlockingArea").get_overlapping_areas().size() > 1 and enemy.tipo == 0

func update(delta):
	if red_condition() or blue_condition():
			emit_signal("finished", enemy.special)
	if enemy.minimun_range_flag:
			emit_signal("finished", "minimun_range")
	if not enemy.is_stunned:
		target = player.global_position - enemy.global_position
		velocity += target
		velocity *= friction
		enemy.look_at(player.global_position)
		#enemy.move_and_slide(velocity.normalized() * enemy.speed)
		enemy.position += velocity.normalized() * enemy.speed * delta
