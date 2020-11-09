extends Node2D

onready var particles = get_child(0)

func _on_Timer_timeout():
	queue_free()
