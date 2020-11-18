extends Area2D

func _physics_process(_delta):
	if scale.x < 8:
		scale.x *= 1.1
	if scale.y < 5:
		scale.y *= 1.1
	for area in get_overlapping_areas():
		if area.is_in_group("Enemy"):
			area.burn()
			area.takeDamage(GlobalVariables.BFdmg)

func remove():
	get_parent().call_deferred("remove_child", self)
	queue_free()


func _on_Timer_timeout():
	hide()
	remove()
