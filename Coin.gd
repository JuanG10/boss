extends Area2D

var show_hide = false
var twinkle_time:float = 1

onready var coin_animation:AnimatedSprite = $AnimatedSprite
onready var twinkle_timer:Timer = 

func initialize(pos):
	position = pos

func grab():
	$PickUpSound.play(0)
	GlobalVariables.money += 10
	hide()
	yield(get_tree().create_timer(.4), "timeout")
	queue_free()

func _on_Timer_timeout():
	queue_free()

func _on_Timer2_timeout():
	if show_hide: coin_animation.hide()
	else: coin_animation.show()
	twinkle_time -= 0.15
	show_hide = not show_hide
	$Timer2.start(twinkle_time)
