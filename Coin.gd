extends Area2D

func initialize(pos):
	position = pos

func remove():
	get_parent().remove_child(self)
	queue_free()

func grab():
	$PickUpSound.play(0)
	GlobalVariables.money += 10
	hide()
	yield(get_tree().create_timer(.4), "timeout")
	remove()

func _on_Timer_timeout():
	remove()
