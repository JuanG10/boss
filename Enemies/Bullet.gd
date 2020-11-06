extends Area2D

var speed = 2.4
var velocity = Vector2()
var player
var dmg

var colores = [Color(0, 0, 1),Color(0,1,0),Color(1,0,0)]
var collisiones = [0b1, 0b10, 0b100]

func start(pos, dir, p, damage, n):
	rotation = dir
	position = pos
	player   = p
	dmg      = damage
	velocity = Vector2(speed, 0).rotated(rotation)
	$Sprite.modulate = colores[n]
	collision_layer = collisiones[n]
	collision_mask  = collisiones[n]

func _physics_process(_delta):
	position += velocity

func _on_player_collision(area):
	if area == player:
		player.takeDamage(dmg)
		remove()

func remove():
	get_parent().remove_child(self)
	queue_free()


func _on_Timer_timeout():
	remove()
