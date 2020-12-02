extends Node

var timer = Timer.new()
var enemyCounter = 24
var counter = 0
export(int) var level_id
func _ready():
	ManagerLevels.level_crossing = false
	LevelPrimitives.initialize($Player, self)
	LevelPrimitives.playing = true
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	add_child(timer)

func _process(_delta):
	if timer.is_stopped() and counter < 2:
		timer.start()
		LevelPrimitives.spawnAdvanced(2)
		LevelPrimitives.spawnBasic(5)
		LevelPrimitives.spawnMelee(5)
		counter += 1
	if enemyCounter == 0:
		LevelPrimitives.playing   = false
		LevelPrimitives.retry     = false
		LevelPrimitives.nextLevel = "res://Levels/Level 5.tscn"
		$Player/HUD/GotoShop.show()
	
