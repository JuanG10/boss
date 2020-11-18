extends "res://state_machine/state.gd"

var player
var enemy
var target = Vector2.ZERO
var velocity
var friction
var acc

#var Pave  = Vector2.ZERO
#var Vave  = Vector2.ZERO
#var Save  = Vector2.ZERO
var steer = Vector2.ZERO 
#var lookS = Vector2.ZERO
#var vel   = Vector2.ZERO

func initialize(p, e):
	player = p
	enemy = e
	friction = enemy.friction
	velocity = enemy.velocity

func update(delta):
	if enemy.get_node("FlockingArea").get_overlapping_areas().size() < 2:
		emit_signal("finished", "chasing")
	if enemy.minimun_range_flag:
		emit_signal("finished", "minimun_range")
	acc = Vector2.ZERO
	steer = Vector2.ZERO
	calc_cohesion()
	calc_seek()
	calc_alignment()
	calc_separation()
	velocity += steer.normalized()
	#enemy.move_and_slide(velocity.normalized() * enemy.speed)
	enemy.position += velocity.normalized() * enemy.speed * delta
	enemy.look_at(player.global_position)

func calc_seek():
	acc = (player.global_position - enemy.global_position).normalized()
	steer += (acc - velocity) * 2

func calc_cohesion():
	var flock_mates = enemy.get_node("FlockingArea").get_overlapping_areas()
	var average = Vector2.ZERO
	
	if flock_mates.size() > 1:
		for f in flock_mates:
			if f != enemy:
				average += f.get_global_position() - enemy.get_global_position()
		average /= flock_mates.size() - 1
		#average -= enemy.get_global_position()
	
		acc      = average.normalized()
		var u    = acos(acc.dot(velocity.normalized())) / PI
		steer   += acc * u * .5

func calc_separation():
	var flock_mates = enemy.get_node("FlockingArea").get_overlapping_areas()
	var average = Vector2.ZERO

	if flock_mates.size() > 1:
		for f in flock_mates:
			if f != enemy:
				average += f.get_global_position() - enemy.get_global_position()
		average /= flock_mates.size() - 1
		acc      = average.normalized()

		var u    = 1/(average - enemy.get_global_position()).length()
		steer   -= acc * u

func calc_alignment():
	var average = Vector2.ZERO
	var flock_mates = enemy.get_node("FlockingArea").get_overlapping_areas()

	if flock_mates.size() > 1:
		for f in flock_mates:
			if f != enemy:
				average += player.get_global_position() - f.get_global_position()
		average /= flock_mates.size() - 1
		acc      = average.normalized()
		
		var v    = acos(acc.dot(velocity.normalized())) / PI
		steer   += acc * v
