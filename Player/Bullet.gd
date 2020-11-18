extends Area2D

var speed = 2
var velocity = Vector2()
var dmg
var state

func start(pos, dir, damage, state_):
	rotation = dir
	position = pos
	dmg      = damage
	state    = state_
	velocity = Vector2(speed, 0).rotated(rotation)


func set_speed(value_speed):
	speed = value_speed

func on_enemy_entered(_body_id, body, _body_shape, _area_shape):
	state.handle(body)
	body.takeDamage(0)
	remove()

func _physics_process(_delta):
	position += velocity

func remove():
	get_parent().call_deferred("remove_child", self)
	queue_free()

func takeDamage():
	pass

func _on_Timer_timeout():
	remove()
