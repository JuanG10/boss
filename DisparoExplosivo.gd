extends Node2D

var velocity = Vector2()
var speed = 2.4

func activate_explosion():
	$Explosion/Particles2D.emitting = true
	
func _physics_process(delta):
	position += velocity

func set_values():	
	velocity = Vector2(speed, 0).rotated(rotation)
	
func explosion():
	if($Bullet.get_collision()):
		$Explosion/Particles2D


func _on_Area2D_body_entered(body):
		activate_explosion()
		$Timer.set_wait_time(1)
		$Timer.start()






func _on_Timer_timeout():
	queue_free()
