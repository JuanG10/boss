extends Area2D

var speed = 2
var velocity = Vector2()
var dmg

func start(pos, dir, damage, col):
	rotation = dir
	position = pos
	dmg      = damage
	velocity = Vector2(speed, 0).rotated(rotation)
	collision_layer = col
	collision_mask  = col

func _physics_process(_delta):
	position += velocity

func remove():
	get_parent().remove_child(self)
	queue_free()

func takeDamage():
	pass

func _on_Timer_timeout():
	remove()
