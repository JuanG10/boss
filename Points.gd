extends Label

func _ready():
	set_text("Points: " + str(GlobalVariables.points))

func on_update():
	set_text("Points: " + str(GlobalVariables.points))
