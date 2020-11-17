extends Node

onready var melee_template = preload("res://Enemies/MeleeEnemy/MeleeEnemy.tscn")
onready var basic_template = preload("res://Enemies/BasicEnemy/BasicEnemy.tscn")
onready var advanced_tmplt = preload("res://Enemies/AdvancedEnemy/AdvancedEnemy.tscn")

var timer = Timer.new()

var points = 0

func _ready():
	$Player.initialize($Player/CanvasLayer/HP, $Player/CanvasLayer/Coins)
	spawnMelee(1)
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	add_child(timer)

func _process(_delta):
	if timer.is_stopped():
		timer.start()
		if points < 100:
			FogBackground.change_bg_octaves(2)
			spawnMelee(6)
		elif points < 300:
			FogBackground.change_bg_octaves(3)
			spawnMelee(4)
			spawnBasic(2)
		elif points < 500:
			FogBackground.change_bg_octaves(4)
			spawnMelee(3)
			spawnBasic(2)
			spawnAdvanced(1)
		elif points < 1000:
			FogBackground.change_bg_octaves(5)
			spawnMelee(6)
			spawnBasic(1)
			spawnAdvanced(3)
		elif points < 2000:
			FogBackground.change_bg_octaves(6)
			spawnMelee(4)
			spawnBasic(6)
			spawnAdvanced(2)
		else:
			FogBackground.change_bg_octaves(1)
			spawnBasic(6)
			spawnAdvanced(6)

func spawnMelee(n):
	for _i in range(n):
		var enemy:KinematicBody2D = melee_template.instance()
		enemy.initialize($Player,rand_range(0,3))
		enemy.set_position(RandomPos()) 
		add_child(enemy)

func spawnBasic(n):
	for _i in range(n):
		var enemy:KinematicBody2D = basic_template.instance()
		enemy.initialize($Player,rand_range(0,3))
		enemy.set_position(Vector2(RandomPos())) 
		add_child(enemy)
	
func spawnAdvanced(n):
	for _i in range(n):
		var enemy:KinematicBody2D = advanced_tmplt.instance()
		enemy.initialize($Player,rand_range(0,3))
		enemy.set_position(Vector2(RandomPos())) 
		add_child(enemy)

func RandomPos():
	return(Vector2(random_x(), random_y()))
	
func random_x():
	return rand_range(0, 1223)

func random_y():
	return rand_range(0, 600)
