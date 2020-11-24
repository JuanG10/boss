extends Label

func _ready():
	set_text("Coins:" + str(GlobalVariables.money))

func on_update():
	set_text("Coins:" + str(GlobalVariables.money))
