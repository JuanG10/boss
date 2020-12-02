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
	if GlobalVariables.RedSpecial or GlobalVariables.BlueSpecial or GlobalVariables.OrangeSpecial:
		$Complementos.get_node("Habilities").show()
		yield(get_tree().create_timer(2), "timeout")
		$Complementos.get_node("Habilities").hide()


func _process(_delta):
	if timer.is_stopped() and counter < 3:
		timer.start()
		LevelPrimitives.spawnAdvanced(4)
		LevelPrimitives.spawnBasic(3)
		LevelPrimitives.spawnMelee(10)
		counter += 1
	if enemyCounter == 0:
		LevelPrimitives.endless_unlocked = true
		LevelPrimitives.playing   = false
		LevelPrimitives.retry     = false
		LevelPrimitives.nextLevel = "res://Levels/Level 6.tscn"
		$Player/HUD/GotoShop.show()
	
