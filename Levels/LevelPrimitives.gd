extends Node

onready var melee_template = preload("res://Enemies/MeleeEnemy/MeleeEnemy.tscn")
onready var basic_template = preload("res://Enemies/BasicEnemy/BasicEnemy.tscn")
onready var advanced_tmplt = preload("res://Enemies/AdvancedEnemy/AdvancedEnemy.tscn")
onready var p_menu_tmplt   = preload("res://Menues/PauseMenu.tscn")

var player
var level
var nextLevel = "res://Levels/Level 1.tscn"
var pause_menu

var retry   = false
var playing = true

func initialize(p, l):
	player     = p
	level      = l
	pause_menu = p_menu_tmplt.instance()
	level.add_child(pause_menu)
	level.get_node("PauseMenu").myHide()
	var label = Label.new()
	label.set_text("Orange enemies grow stronger each time you die. Watch out!")
	label.set_position(Vector2(430,160))
	if retry:
		level.add_child(label)
		yield(get_tree().create_timer(2), "timeout")
		label.hide()

func pause():
	get_tree().paused = true
	level.get_node("PauseMenu").myShow()

func unPause():
	get_tree().paused = false
	level.get_node("PauseMenu").myHide()
	level.get_node("Camera2D")._set_current(true)

func spawnMelee(n):
	for _i in range(n):
		var enemy:Area2D = melee_template.instance()
		enemy.initialize(player, randi()%3)
		enemy.set_position(RandomPos()) 
		level.add_child(enemy)

func spawnBasic(n):
	for _i in range(n):
		var enemy:Area2D = basic_template.instance()
		enemy.initialize(player, randi()%3)
		enemy.set_position(Vector2(RandomPos())) 
		level.add_child(enemy)

func spawnAdvanced(n):
	for _i in range(n):
		var enemy:Area2D = advanced_tmplt.instance()
		enemy.initialize(player, randi()%3)
		enemy.set_position(Vector2(RandomPos())) 
		level.add_child(enemy)

func RandomPos():
	return(Vector2(random_x(), random_y()))
	
func random_x():
	var ret
	if randi() % 2 == 1:
		ret = 126.5
	else:
		ret = 906.5
	return ret

func random_y():
	var ret
	if randi() % 2 == 1:
		ret = 81.5
	else:
		ret = 521.5
	return ret
