extends Node

var timer = Timer.new()
var enemyCounter = 21
var counter = 0

func _ready():
	LevelPrimitives.initialize($Player, self)
	LevelPrimitives.playing = true
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	add_child(timer)

func _process(_delta):
	if timer.is_stopped() and counter < 3:
		timer.start()
		LevelPrimitives.spawnBasic(2)
		LevelPrimitives.spawnMelee(5)
		counter += 1
	if enemyCounter == 0:
		LevelPrimitives.playing   = false
		LevelPrimitives.retry     = false
		LevelPrimitives.nextLevel = "res://Levels/Level 4.tscn" 
		$GotoShop.show()
	
