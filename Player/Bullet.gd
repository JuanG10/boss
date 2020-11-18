extends Area2D

var speed = 2
var velocity = Vector2()
var dmg
var state
var type

func start(pos, dir, damage, tipo, estado):
	rotation = dir
	position = pos
	dmg      = damage
	state    = estado
	velocity = Vector2(speed, 0).rotated(rotation)
	type = tipo

func on_enemy_entered(_d, area, _a, _b):
	if area.is_in_group("Enemy"):
		state.handle(area)
		if (area.tipo + 1)%3 == type:
			area.takeDamage(dmg)
		else:
			area.takeDamage(dmg/3)
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
