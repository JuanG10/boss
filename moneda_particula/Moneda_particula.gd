extends Particles2D


func _ready():
	$Timer.set_wait_time(1.2)
	$Timer.start()

func _on_Timer_timeout():
	queue_free()
