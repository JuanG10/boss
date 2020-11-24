extends Particles2D


func _physics_process(delta):
	if emitting && $Area2D/CollisionShape2D.disabled:
		$Area2D/CollisionShape2D.disabled = false


func _on_Area2D_body_entered(body):
	body.takeDamage(20)
