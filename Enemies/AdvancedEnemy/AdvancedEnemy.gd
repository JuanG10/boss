extends Area2D

var player
var speed = 40
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var health = 70
var dmg = 10

var timer  = Timer.new()

var Bullet = preload("res://Enemies/Bullet.tscn")

var colores = [Color(0, 0, 1),Color(0,1,0),Color(1,0,0)]
var collisiones = [0b1, 0b10, 0b100]
var tipo

func _ready():
	timer.set_one_shot(true)
	timer.set_wait_time(.4)
	add_child(timer)

#acá habría que agregar el color y las colisiones
func initialize(t, n):
	player = t
	$Sprite.modulate = colores[n]
	collision_layer = collisiones[n]
	collision_mask  = collisiones[n]
	tipo = n

func _process(delta):
	target = player.global_position - global_position
	velocity += target
	velocity *= friction
	look_at(player.global_position)
	position += velocity.normalized() * speed * delta
	if(timer.is_stopped()):
		shoot()

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
		player.takeDamage(10)

func shoot():
	for _i in range(3):
		var b = Bullet.instance()
		b.start($Muzzle.global_position, rotation, player, dmg, tipo)
		get_parent().add_child(b)
		yield(get_tree().create_timer(.02), "timeout")
	timer.start()


func _on_death():
	get_parent().points += 30
	for i in range(5):
		var c = GlobalVariables.coin.instance()
		c.initialize(position + Vector2(i,0))
		get_parent().call_deferred("add_child", c)
