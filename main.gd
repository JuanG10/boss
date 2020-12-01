extends Node

export(int) var level_id

var timer = Timer.new()

var points = GlobalVariables.points

func _ready():
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	add_child(timer)

func _process(_delta):
	if timer.is_stopped():
		timer.start()
		if points < 100:
			LevelPrimitives.spawnMelee(6)
		elif points < 300:
			LevelPrimitives.spawnMelee(4)
			LevelPrimitives.spawnBasic(2)
		elif points < 500:
			LevelPrimitives.spawnMelee(3)
			LevelPrimitives.spawnBasic(2)
			LevelPrimitives.spawnAdvanced(1)
		elif points < 1000:
			LevelPrimitives.spawnMelee(6)
			LevelPrimitives.spawnBasic(1)
			LevelPrimitives.spawnAdvanced(3)
		elif points < 2000:
			LevelPrimitives.spawnMelee(4)
			LevelPrimitives.spawnBasic(6)
			LevelPrimitives.spawnAdvanced(2)
		else:
			LevelPrimitives.spawnBasic(6)
			LevelPrimitives.spawnAdvanced(6)
