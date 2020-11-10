extends Area2D

var player
var speed = 130
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var health = 25

var colores = [Color(0, 0, 1),Color(0,1,0),Color(1,0,0)]
var collisiones = [0b1, 0b10, 0b100]

var explosion_color:Color

#acá habría que agregar el color y las colisiones
func initialize(t, n):
	player = t
	$Sprite.modulate = colores[n]
	explosion_color = colores[n]
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
		get_parent().call_deferred("remove_child", self)
		queue_free()

func burn():
	for i in range(10):
		takeDamage(player.brn_dmg)
		yield(get_tree().create_timer(.1), "timeout")


func _on_area_entered(area):
	if area.filename == "res://Player/Bullet.tscn":
		if area.burn:
			burn()
		takeDamage(player.dmg)
		area.remove()
	if area.name == player.name: 
		player.takeDamage(15)


func _on_death():
	_create_explosion()
	
	get_parent().points += 10
	var c = GlobalVariables.coin.instance()
	c.initialize(position)
	get_parent().call_deferred("add_child", c)

func _create_explosion():
	var explosion = GlobalVariables.EXPLOSION.instance()
	explosion.position = position
	explosion.get_child(0).process_material.color_ramp.gradient.colors[1] = explosion_color
	explosion.get_child(0).emitting = true
	get_parent().call_deferred("add_child", explosion)