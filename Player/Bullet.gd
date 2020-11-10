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

func _physics_process(_delta):
	position += velocity

func remove():
	get_parent().remove_child(self)
	queue_free()

func takeDamage():
	pass

func _on_Timer_timeout():
	remove()
