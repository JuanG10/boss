extends Node

onready var melee_template = preload("res://Enemies/MeleeEnemy/MeleeEnemy.tscn")
onready var basic_template = preload("res://Enemies/BasicEnemy/BasicEnemy.tscn")
onready var advanced_tmplt = preload("res://Enemies/AdvancedEnemy/AdvancedEnemy.tscn")

var timer = Timer.new()

var points = 0

func _ready():
	$Player.initialize($Player/CanvasLayer/HP, $Player/CanvasLayer/Coins)
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	add_child(timer)

func _process(_delta):
	if timer.is_stopped():
		timer.start()
		if points < 100:
			spawnMelee(6,randi()%3)
		elif points < 300:
			spawnMelee(4,randi()%3)
			spawnBasic(2,randi()%3)
		elif points < 500:
			spawnMelee(3,randi()%3)
			spawnBasic(2,randi()%3)
			spawnAdvanced(1,randi()%3)
		elif points < 1000:
			spawnMelee(6,randi()%3)
			spawnBasic(1,randi()%3)
			spawnAdvanced(3,randi()%3)
		elif points < 2000:
			spawnMelee(4,randi()%3)
			spawnBasic(6,randi()%3)
			spawnAdvanced(2,randi()%3)
		else:
			spawnBasic(6,randi()%3)
			spawnAdvanced(6,randi()%3)

func spawnMelee(n, c):
	for _i in range(n):
		var enemy:Area2D = melee_template.instance()
		enemy.initialize($Player, c)
		enemy.set_position(RandomPos()) 
		add_child(enemy)

func spawnBasic(n, c):
	for _i in range(n):
		var enemy:Area2D = basic_template.instance()
		enemy.initialize($Player, c)
		enemy.set_position(Vector2(RandomPos())) 
		add_child(enemy)
	
func spawnAdvanced(n, c):
	for _i in range(n):
		var enemy:Area2D = advanced_tmplt.instance()
		enemy.initialize($Player, c)
		enemy.set_position(Vector2(RandomPos())) 
		add_child(enemy)

func RandomPos():
	return(Vector2(random_x(), random_y()))
	
func random_x():
	return rand_range(0, 1223)

func random_y():
	return rand_range(0, 600)
