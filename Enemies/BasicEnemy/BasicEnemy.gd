extends Area2D

var player
var speed = 60
var friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var slow_timer = Timer.new()
var stun_timer = Timer.new()
var is_stunned = false

var health = 45
var dmg = 20
var atk_speed = .8

var special
var minimun_range_flag = false

var timer = Timer.new()

var colores     = [Color(0.0627, 0.102, 0.451),Color(0.551, 0.1582, 0.041),Color(0.251, 0.051, 0.0431)]
var specials    = ["special_blue", "special_orange", "special_red"]
var tipo
var color_actual
var color_gris  = Color(0.345098,0.329412,0.329412,1)

var explosion_color:Color

var relativeVel = Vector2.ZERO
var closingPos  = Vector2.ZERO
var closingTime = Vector2.ZERO
var prediction  = Vector2.ZERO

const POINTS = 20

func _ready():
	$State_handler.init(player, self)
	timer.set_one_shot(true)
	stun_timer.set_one_shot(true)
	slow_timer.set_one_shot(true)
	add_child(stun_timer)
	add_child(slow_timer)
	add_child(timer)

#acá habría que agregar el color y las colisiones
func initialize(t, n):
	player = t
	$Sprite.modulate = colores[n]
	color_actual     = colores[n]
	explosion_color = colores[n]
	tipo = n
	special = specials[n]
	if special == "special_orange" and LevelPrimitives.retry == true:
		GlobalVariables.Bdmg *= 1.1
		GlobalVariables.Bhealth *= 1.1
		dmg = GlobalVariables.Bdmg
		health = GlobalVariables.Bhealth

func recibi_danio():
	$Sprite.modulate = color_gris
	$Timer.set_wait_time(0.3)
	$Timer.start()

func volver_a_color_actual():
	$Sprite.modulate = color_actual 
	
		
func close_enough(area):
	if area.name == player.name:
		minimun_range_flag = true

func far_enough(area):
	if area.name == player.name:
		minimun_range_flag = false

func _process(_delta):
	update()
	if stun_timer.is_stopped():
		is_stunned = false
	if slow_timer.is_stopped():
		speed = 130
	if(timer.is_stopped() and not is_stunned):
		shoot()

func update():
	relativeVel = player.velocity*player.speed - Vector2(4,0).rotated(rotation)
	closingPos  = player.global_position - global_position
	closingTime = closingPos.length() / relativeVel.length() + 0.0000001
	prediction  = player.global_position + (player.velocity * player.speed * closingTime)

func takeDamage(n):
	health -= n
	recibi_danio()
	if health <= 0:
		BulletHandler.reParent(self)
		get_parent().call_deferred("remove_child", self)
		queue_free()

func burn():
	for _i in range(10):
		takeDamage(player.brn_dmg)
		yield(get_tree().create_timer(.1), "timeout")

func stun(time):
	stun_timer.start(time)
	is_stunned = true

func slow(slow, time):
	if slow_timer.is_stopped():
		slow_timer.start(time)
		speed *= slow

func shoot():
	BulletHandler.add_bullet([$Muzzle.global_position, colores[tipo], rotation, self])
	#var b = Bullet.instance()
	#b.start($Muzzle.global_position, rotation, player, dmg, tipo)
	#get_parent().add_child(b)
	timer.start(atk_speed)

func _on_death():
	_create_floating_text()
	_create_explosion()
	GlobalVariables.points += POINTS
	get_tree().current_scene.get_node("Player").update_score()
	get_parent().enemyCounter -= 1
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

func _create_floating_text()->void:
	var text = GlobalVariables.TEXT.instance()
	text.amount = POINTS
	text.position = position
	text.color = explosion_color
	get_parent().call_deferred("add_child", text)


func _on_Timer_timeout():
	volver_a_color_actual()
