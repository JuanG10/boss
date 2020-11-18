extends "res://state_machine/state.gd"

var player
var enemy
var target = Vector2.ZERO
var friction
var acc

var steer = Vector2.ZERO 

func initialize(p, e):
	player = p
	enemy = e
	friction = enemy.friction

func update(delta):
	if enemy.get_node("FlockingArea").get_overlapping_areas().size() < 2:
		emit_signal("finished", "chasing")
	if enemy.minimun_range_flag:
		emit_signal("finished", "minimun_range")
	
	var flock_mates = enemy.get_node("FlockingArea").get_overlapping_areas()
	acc = Vector2.ZERO
	steer = Vector2.ZERO
	calc_cohesion(flock_mates)
	calc_seek()
	calc_alignment(flock_mates)
	calc_separation(flock_mates)
	enemy.velocity += steer.normalized()
	#enemy.move_and_slide(velocity.normalized() * enemy.speed)
	enemy.position += enemy.velocity.normalized() * enemy.speed * delta
	enemy.look_at(player.global_position)

func calc_seek():
	acc = (player.global_position - enemy.global_position).normalized()
	steer += (acc - enemy.velocity) * 2

func calc_cohesion(flock_mates):
	var average = Vector2.ZERO
	
	if flock_mates.size() > 1:
		for f in flock_mates:
			if f != enemy:
				average += f.get_global_position() - enemy.get_global_position()
		average /= flock_mates.size() - 1
		#average -= enemy.get_global_position()
	
		acc      = average.clamped(1)
		var u    = acos(acc.dot(enemy.velocity.clamped(1))) / PI
		steer   += acc * u

func calc_separation(flock_mates):
	if flock_mates.size() > 1:
		for f in flock_mates:
			if f != enemy:
				if (f.global_position - enemy.global_position).length() < 20:
					steer += (enemy.global_position - f.global_position).normalized() * 2

func calc_alignment(flock_mates):
	var average = Vector2.ZERO

	if flock_mates.size() > 1:
		for f in flock_mates:
			if f != enemy:
				average += f.velocity
		average /= flock_mates.size() - 1
		acc      = average.clamped(1)

		var v    = acos(acc.dot(enemy.velocity.normalized())) / PI
		steer   += acc * v
