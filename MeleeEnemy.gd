extends Area2D

var player
var speed = 130
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var health = 25

#acá habría que agregar el color y las colisiones
func initialize(t):
	player = t

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
	if area.name == "pBullet":
		takeDamage(player.dmg)
		area.remove()
	if area.name == player.name: 
		player.takeDamage(15)
