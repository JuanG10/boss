extends Button

export (String) var route

func _pressed():
	get_tree().change_scene(route)
