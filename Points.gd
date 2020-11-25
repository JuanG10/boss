extends Label

func _ready():
	set_text("Score:" + str(GlobalVariables.points))

func on_update():
	set_text("Score:" + str(GlobalVariables.points))
