extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if scale.length() < 30:
		scale *= 1 + delta*2
	else:
		remove()

func remove():
	hide()
	get_parent().call_deferred("remove_child", self)
	queue_free()

func _on_enemy_collition(body):
	body.slow(GlobalVariables.slow_ring_effect, 5)
