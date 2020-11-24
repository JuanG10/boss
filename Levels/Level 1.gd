extends Node

var timer = Timer.new()
var enemyCounter = 8
var counter = 0

export(int) var level_id

func _ready():
	LevelPrimitives.initialize($Player, self)
	LevelPrimitives.playing = true
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	add_child(timer)
	if LevelPrimitives.retry:
		yield(get_tree().create_timer(2), "timeout")
		$Explicacion.hide() 
	else:
		yield(get_tree().create_timer(5), "timeout")
		$Explicacion.hide() 

func player_moved():
	return Input.is_action_just_pressed('down') || Input.is_action_just_pressed('up') || Input.is_action_just_pressed('left') || Input.is_action_just_pressed('right')

func _process(_delta):
	if timer.is_stopped() and counter < 2:
		timer.start()
		LevelPrimitives.spawnMelee(4)
		counter += 1
	if enemyCounter == 0:
		LevelPrimitives.playing   = false
		LevelPrimitives.retry     = false
		LevelPrimitives.nextLevel = "res://Levels/Level 2.tscn"
		$Player/HUD/GotoShop.show()
