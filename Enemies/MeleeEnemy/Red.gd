extends "res://state_machine/state.gd"

var player
var enemy
var target = Vector2.ZERO
var velocity = Vector2.ZERO
var friction
var timer = Timer.new()

func enter():
	timer.set_one_shot(true)
	add_child(timer)
	timer.start(2)

func initialize(p, e):
	player = p
	enemy = e
	friction = enemy.friction
	
func update(_delta):
	if not enemy.is_stunned:
		target = player.global_position - enemy.global_position
		velocity += target
		velocity *= friction
		enemy.look_at(player.global_position)
		enemy.move_and_slide(velocity.normalized() * enemy.speed * 1.5)
	if not enemy.charge_flag or timer.is_stopped():
		timer.stop()
		enemy.charge_flag = false
		emit_signal("finished", "chasing")
