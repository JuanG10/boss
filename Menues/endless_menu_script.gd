extends Button

export (String) var route

func _pressed():
	if LevelPrimitives.endless_unlocked:
		get_tree().change_scene(route)
	else:
		$Label.show()
		yield(get_tree().create_timer(1.5), "timeout")
		$Label.hide()
