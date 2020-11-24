extends Button



func _ready():
	set_text("Go to shop")

func _pressed():
	get_tree().change_scene("res://UpgradeScreen/UpgradeWindow.tscn")
	
