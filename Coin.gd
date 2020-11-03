extends Area2D

func initialize(pos):
	position = pos

func remove():
	get_parent().remove_child(self)
	queue_free()

func grab():
	GlobalVariables.money += 10
	remove()

func _on_Timer_timeout():
	remove()
