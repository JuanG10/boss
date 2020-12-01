extends Button

export (String) var route

func _pressed():
	get_tree().change_scene(route)


func _on_Start_mouse_entered():
	print("sdadasdsadssd")


func _on_Endless_mouse_entered():
	pass # Replace with function body.
