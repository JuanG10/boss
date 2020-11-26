extends Camera2D

var shake_amount:float

func _physics_process(delta):
	if !$Timer.is_stopped():
		var rand_shake:float = rand_range(-1.0, 1.0) * shake_amount
		set_offset(Vector2(rand_shake, rand_shake))
	else: set_offset(Vector2(0,0))

func shake(shake_amount,shake_time):
	self.shake_amount = shake_amount
	$Timer.start(shake_time)
