extends "res://state_machine/state.gd"

var player
var enemy
var target = Vector2.ZERO
var velocity = Vector2.ZERO
var friction

var Pave  = Vector2.ZERO
var Vave  = Vector2.ZERO
var steer = Vector2.ZERO 

func initialize(p, e):
	player = p
	enemy = e
	friction = enemy.friction

func update(_delta):
	emit_signal("finished", "chasing")
#	if enemy.get_node("ChargeRange").get_overlapping_bodies().size() == 0:
#		emit_signal("finished", "chasing")
#	calc_cohesion()
#	calc_aligment()
#	enemy.move_and_slide(steer)

#func calc_cohesion():
#	target = player.global_position - enemy.global_position
#	var flock_mates = enemy.get_node("ChargeRange").get_overlapping_bodies()
#	for f in flock_mates:
#		Pave += f.get_global_position() - enemy.get_global_position()
#	Pave /= flock_mates.size()
#	Pave -= enemy.get_global_position()
#	Pave  = Pave.normalized()
#	Pave  = acos(Pave * target.normalized()) / PI
#	steer += Pave
	
#func calc_aligment():
#	target = player.global_position - enemy.global_position
#	var flock_mates = enemy.get_node("ChargeRange").get_overlapping_bodies()
#	for f in flock_mates:
#		Vave += player.get_global_position() - f.get_global_position()
#	Vave /= flock_mates.size()
#	Vave  = Vave.normalized()
#	Vave  = acos(Vave * target.normalized()) / PI
#	steer += Vave
