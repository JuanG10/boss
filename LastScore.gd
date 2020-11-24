extends Label


func _ready():
	set_text("MAX SCORE:" + str(GlobalVariables.last_points))
