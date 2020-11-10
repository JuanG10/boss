extends Node2D

# La animación debe ser colocada como primer hijo manualmente.
onready var animation:AnimatedSprite = get_child(0)
var stop_animation = false

func _ready():
	animation.stop()

func _play_if_player(area:Area2D, animation_name:String)->void:
	if area.name == "Player" && !stop_animation:
		animation.play(animation_name)

func _on_Arise_area_entered(area):
	_play_if_player(area,"surgir")

func _on_Arise_area_exited(area):
	_play_if_player(area,"esconderse")

func _on_Activation_area_entered(area):
	_play_if_player(area,"activar")
	if area.name == "Player": stop_animation = true

func _on_TrapAnimation_animation_finished():
	var actual_animation = animation.get_animation()
	match actual_animation:
		"esconderse": _set_last_frame(actual_animation)
		"surgir": _set_last_frame(actual_animation)
		"activar": animation.play("desaparecer")
		"desaparecer": queue_free()

func _set_last_frame(actual_animation_name:String)->void:
	match animation.name:
		"BlueTrapAnimation": animation.set_frame(11)
		"GreenTrapAnimation":
			if actual_animation_name == "esconderse":
				animation.set_frame(5)
			else: animation.set_frame(8)
		"RedTrapAnimation": return
	animation.stop()
