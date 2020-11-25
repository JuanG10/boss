extends Node

var timer = Timer.new()
var enemyCounter = 41
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
	if timer.is_stopped() and counter < 3:
		timer.start()
		LevelPrimitives.spawnAdvanced(4)
		LevelPrimitives.spawnBasic(3)
		LevelPrimitives.spawnMelee(10)
		counter += 1
	if enemyCounter == 0:
		LevelPrimitives.playing   = false
		LevelPrimitives.retry     = false
		LevelPrimitives.nextLevel = "res://Levels/Level 6.tscn" 
		$Player/HUD/GotoShop.show()
	
