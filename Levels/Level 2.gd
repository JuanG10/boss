extends Node

var timer = Timer.new()
var enemyCounter = 8
var counter = 0

func _ready():
	LevelPrimitives.initialize($Player, self)
	LevelPrimitives.playing = true
	$Player.initialize($Player/CanvasLayer/HP, $Player/CanvasLayer/Coins)
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	add_child(timer)
	yield(get_tree().create_timer(3), "timeout")
	$Explicacion.hide()

func _process(_delta):
	if timer.is_stopped() and counter < 2:
		timer.start()
		LevelPrimitives.spawnBasic(1)
		LevelPrimitives.spawnMelee(3)
		counter += 1
	if enemyCounter == 0:
		LevelPrimitives.playing   = false
		LevelPrimitives.retry     = false
		LevelPrimitives.nextLevel = "res://Levels/Level 3.tscn" 
		$GotoShop.show()
	
