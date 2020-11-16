extends Area2D

var speed = 2
var velocity = Vector2()
var dmg
var burn

func start(pos, dir, damage, brn):
	rotation = dir
	position = pos
	dmg      = damage
	burn     = brn
	velocity = Vector2(speed, 0).rotated(rotation)

func on_enemy_entered(_body_id, body, _body_shape, _area_shape):
	if burn:
		body.burn()
	body.takeDamage(dmg)
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
