extends TextureProgress

var temp_value:float
var can_start = false
const TRANSITION_VELOCITY = 5

signal end_animation
var emit_once = true
var not_reverse = false

func _physics_process(delta):
	if can_start:
		if not_reverse: temp_value = get_value() + TRANSITION_VELOCITY
		else: temp_value = get_value() - TRANSITION_VELOCITY
	set_value(temp_value)
	_emit_end()

func _emit_end():
	if get_value() >= max_value && emit_once:
		can_start = false
		emit_once = false
		emit_signal("end_animation")

func _start_animation():
	can_start = true
	emit_once = true
	not_reverse = !not_reverse
