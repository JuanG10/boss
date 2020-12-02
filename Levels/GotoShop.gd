extends Button

func _ready():
	set_text("Go to shop")

func _pressed():
	var level_actual = get_tree().current_scene.level_id
	ManagerLevels.set_actual_level(level_actual)
	BulletHandler.clear()
	MusicController.stop()
	get_tree().change_scene("res://UpgradeScreen/UpgradeWindow.tscn")
