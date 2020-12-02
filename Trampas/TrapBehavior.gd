extends Node2D

# La animación debe ser colocada como primer hijo manualmente.
onready var animation:AnimatedSprite = get_child(0)
var stop_animation = false
var maked_dmg_once = false

const slowdown:float = .75

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
		_on_activated_trap_behavior(area, animation_name)

func _flip_green_to_player(player:Area2D)->void:
	if animation.name == TRAP_NAMES.green:
		if player.position <= position: animation.flip_h = true
		else: animation.flip_h = false

func _on_activated_trap_behavior(player:Area2D, animation_name:String):
	if animation_name == "activar" && !maked_dmg_once:
		match animation.name:
			TRAP_NAMES.blue:
				player.ralentizar(slowdown)
			TRAP_NAMES.green:
				player.start_poison_timers()
			TRAP_NAMES.red: player.takeDamage(20)
		maked_dmg_once = true

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
		"activar": animation.play("desaparecer")
		"desaparecer": queue_free()
