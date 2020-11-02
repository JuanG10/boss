extends Area2D

var player
var speed = 60
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var health = 45
var dmg = 20

var timer = Timer.new()

var Bullet = preload("res://Enemies/Bullet.tscn")

func _ready():
	timer.set_one_shot(true)
	timer.set_wait_time(.3)
	add_child(timer)

#acá habría que agregar el color y las colisiones
func initialize(t):
	player = t

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
	print("ouch")
	if health <= 0:
		get_parent().remove_child(self)
		queue_free()

func _on_area_entered(area):
	if area.name == "pBullet":
		takeDamage(player.dmg)
		area.remove()
	if area.name == player.name: 
		player.takeDamage(10)

func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation, player, dmg)
	get_parent().add_child(b)
	timer.start()
