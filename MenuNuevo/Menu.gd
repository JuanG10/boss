extends Control



func _ready():
	#para mostrar Background.show()
	Background.hide()

func _unhandled_input(event):
	if event.is_action_pressed("cheat"):
		LevelPrimitives.endless_unlocked = true
