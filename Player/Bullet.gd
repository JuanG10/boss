extends Area2D

var speed = 2
var velocity = Vector2()

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(_delta):
	position += velocity

func remove():
	get_parent().remove_child(self)
	queue_free()
