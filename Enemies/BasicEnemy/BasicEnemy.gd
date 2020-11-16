extends KinematicBody2D

var player
var speed = 60
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var health = 45
var dmg = 20

var timer = Timer.new()

var Bullet = preload("res://Enemies/Bullet.tscn")

var colores = [Color(0, 0, 1),Color(0,1,0),Color(1,0,0)]
var collisiones = [0b100000001, 0b100000010, 0b100000100]
var tipo

var explosion_color:Color

func _ready():
	$State_handler.init(player, self)
	timer.set_one_shot(true)
	timer.set_wait_time(.8)
	add_child(timer)

#acá habría que agregar el color y las colisiones
func initialize(t, n):
	player = t
	$Sprite.modulate = colores[n]
	explosion_color = colores[n]
	collision_layer = collisiones[n]
	collision_mask  = collisiones[n]
	tipo = n

func close_enough():
	return false

func _process(_delta):
	if(timer.is_stopped()):
		shoot()

func takeDamage(n):
	health -= n
	if health <= 0:
		get_parent().call_deferred("remove_child", self)
		queue_free()

func _on_area_entered(area):
	if area.filename == "res://Player/Bullet.tscn":
		takeDamage(player.dmg)
		area.remove()
	if area.name == player.name: 
		player.takeDamage(10)

func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation, player, dmg, tipo)
	get_parent().add_child(b)
	timer.start()

func _on_death():
	_create_explosion()
	get_parent().points += 20
	for i in range(3):
		var c = GlobalVariables.coin.instance()
		c.initialize(position + Vector2(rand_range(0, i*10),rand_range(0, i*10)))
		get_parent().call_deferred("add_child", c)

func _create_explosion():
	var explosion = GlobalVariables.EXPLOSION.instance()
	explosion.position = position
	explosion.get_child(0).process_material.color_ramp.gradient.colors[1] = explosion_color
	explosion.get_child(0).emitting = true
	get_parent().call_deferred("add_child", explosion)
