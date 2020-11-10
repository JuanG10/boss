extends Node2D

# La animación debe ser colocada como primer hijo manualmente.
onready var animation:AnimatedSprite = get_child(0)
var stop_animation = false

const TRAP_NAMES = {
	red = "RedTrapAnimation",
	green = "GreenTrapAnimation",
	blue = "BlueTrapAnimation"
}

func _ready():
	animation.play("esconderse")

func _play_if_player(area:Area2D, animation_name:String)->void:
	if area.name == "Player" && !stop_animation:
		_flip_green_to_player(area)
		animation.play(animation_name)

func _flip_green_to_player(player:Area2D)->void:
	if animation.name == TRAP_NAMES.green:
		if player.position <= position: animation.flip_h = true
		else: animation.flip_h = false

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
		TRAP_NAMES.blue: animation.set_frame(11)
		TRAP_NAMES.green:
			if actual_animation_name == "esconderse":
				animation.set_frame(5)
			else: animation.set_frame(8)
		TRAP_NAMES.red: return
	animation.stop()
