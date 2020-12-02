extends Node

var timer = Timer.new()
var enemyCounter = 8
var counter = 0

export(int) var level_id

func _ready():
	ManagerLevels.level_crossing = false
	LevelPrimitives.initialize($Player, self)
	LevelPrimitives.playing = true
	timer.set_one_shot(true)
	timer.set_wait_time(5)
	add_child(timer)
	if LevelPrimitives.retry:
		$Complementos.get_node("Retry").show()
		yield(get_tree().create_timer(2), "timeout")
		$Explicacion.hide() 
		$Explicacion2.hide()
		$Complementos.get_node("Retry").hide()
		$Key_E.hide()
		$Key_Q.hide()
		$Key_W.hide()
		$Key_A.hide()
		$Key_S.hide()
		$Key_D.hide()
	else:
		yield(get_tree().create_timer(5), "timeout")
		$Explicacion.hide() 
		$Explicacion2.hide()
		$Key_Q.hide()
		$Key_E.hide()
		$Key_W.hide()
		$Key_A.hide()
		$Key_S.hide()
		$Key_D.hide()
	if GlobalVariables.RedSpecial or GlobalVariables.BlueSpecial or GlobalVariables.OrangeSpecial:
		$Complementos.get_node("Habilities").show()
		yield(get_tree().create_timer(2), "timeout")
		$Complementos.get_node("Habilities").hide()


func player_moved():
	return Input.is_action_just_pressed('down') || Input.is_action_just_pressed('up') || Input.is_action_just_pressed('left') || Input.is_action_just_pressed('right')

func _process(_delta):
	if Input.is_action_just_pressed("pasue"):
		LevelPrimitives.pause()
	if timer.is_stopped() and counter < 2:
		timer.start()
		LevelPrimitives.spawnMelee(4)
		counter += 1
	if enemyCounter == 0:
		LevelPrimitives.playing   = false
		LevelPrimitives.retry     = false
		LevelPrimitives.nextLevel = "res://Levels/Level 2.tscn"
		$Player/HUD/GotoShop.show()
