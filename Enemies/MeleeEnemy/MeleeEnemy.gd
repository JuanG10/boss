extends Area2D

var player
var speed = 130
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var health = 25

var colores = [Color(0, 0, 1),Color(0,1,0),Color(1,0,0)]
var collisiones = [0b1, 0b10, 0b100]

#acá habría que agregar el color y las colisiones
func initialize(t, n):
	player = t
	$Sprite.modulate = colores[n]
	collision_layer = collisiones[n]
	collision_mask  = collisiones[n]

func _process(delta):
	target = player.global_position - global_position
	velocity += target
	velocity *= friction
	look_at(player.global_position)
	position += velocity.normalized() * speed * delta

func takeDamage(n):
	health -= n
	if health <= 0:
		get_parent().remove_child(self)
		queue_free()

func _on_area_entered(area):
	if area.filename == "res://Player/Bullet.tscn":
		takeDamage(player.dmg)
		area.remove()
	if area.name == player.name: 
		player.takeDamage(15)


func _on_death():
	get_parent().points += 10
	var c = GlobalVariables.coin.instance()
	c.initialize(position)
	get_parent().add_child(c)
