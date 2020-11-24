extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text("Go to shop")

func _pressed():
	get_tree().change_scene("res://UpgradeScreen/UpgradeWindow.tscn")
