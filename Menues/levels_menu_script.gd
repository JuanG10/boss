extends Button

export (String) var route

func _pressed():
	get_tree().change_scene(route)
	Background.show()


func _on_Start_mouse_entered():
	#print("sdadasdsadssd")
	pass


func _on_Endless_mouse_entered():
	pass # Replace with function body.


func _on_Main_Menu_pressed():
		get_tree().change_scene(route)
