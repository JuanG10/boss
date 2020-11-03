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
	#Si coliona con el jugador y las balas son del mismo color, lo daña
	if area.name == "Area2D" && $Sprite.modulate == player.modulate_color():
			print("entra")
			player.takeDamage(dmg)
			remove()
			
#Set del color a las balas			
func color_set(un_color):
	$Sprite.modulate = un_color
		
func remove():
	get_parent().remove_child(self)
	queue_free()
