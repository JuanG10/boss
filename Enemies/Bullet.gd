extends Area2D

var speed = 2.4
var velocity = Vector2()
var player
var dmg
var explosion_collision = false

var colores     = [Color(0.0627, 0.102, 0.451),Color(0.551, 0.1582, 0.041),Color(0.251, 0.051, 0.0431)]
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
		explosion_collision = true
		player.takeDamage(dmg)
		remove()

func get_collision():
	return explosion_collision

func remove():
	get_parent().call_deferred("remove_child", self)
	queue_free()

func _on_Timer_timeout():
	remove()
