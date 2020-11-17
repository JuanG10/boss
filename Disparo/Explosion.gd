extends Node2D


func _ready():
	$Timer.set_wait_time(1)
	$Timer.start()




func _on_Timer_timeout():
	pass


func _on_Area2D_area_entered(area):
	pass # Replace with function body.
