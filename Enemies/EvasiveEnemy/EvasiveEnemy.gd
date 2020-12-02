extends Area2D

const speed = 130
const friction = 0.95
var target := Vector2.ZERO
var velocity := Vector2.ZERO

var health = 50

onready var player = get_tree().get_nodes_in_group("Player")[0]

onready var limite_minimo_pantalla = get_tree().get_nodes_in_group("borde_minimo")[0].global_position
onready var limite_maximo_pantalla = get_tree().get_nodes_in_group("borde_maximo")[0].global_position

func _process(delta):
	rotation += 5 * delta
	_not_pass_frame_limit()

func _physics_process(delta):
	target = player.global_position - global_position
	velocity += target
	velocity *= friction
	velocity  = velocity.normalized()
	position += velocity * speed * delta

func _not_pass_frame_limit():
	# frame = marco de los bordes de la pantalla.
	if global_position.x < limite_minimo_pantalla.x:
		global_position.x = limite_minimo_pantalla.x + 2
	elif global_position.x > limite_maximo_pantalla.x:
		global_position.x = limite_maximo_pantalla.x - 2
	
	if global_position.y < limite_minimo_pantalla.y:
		global_position.y = limite_minimo_pantalla.y + 2
	elif global_position.y > limite_maximo_pantalla.y:
		global_position.y = limite_maximo_pantalla.y - 2

func _on_Evasion_range_area_entered(area):
	print(area.get_name())
	if area.get_name().begins_with("Bullet"):
		if global_position.x < area.global_position.x:
			velocity.x -= 30
		else: velocity.x += 30

func _on_EvasiveEnemy_area_entered(area):
	if area == player:
		player.takeDamage(25)

func takeDamage(n):
	health -= n
	if health <= 0:
		get_parent().call_deferred("remove_child", self)
		queue_free()
