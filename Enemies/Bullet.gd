extends Area2D

var speed = 2.4
var velocity = Vector2()
var player
var dmg

func start(pos, dir, p, damage):
	rotation = dir
	position = pos
	player   = p
	dmg      = damage
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(_delta):
	position += velocity

func _on_player_collision(area):
	if area == player:
		player.takeDamage(dmg)
		remove()

func remove():
	get_parent().remove_child(self)
	queue_free()
