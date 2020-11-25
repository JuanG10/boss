extends TextureProgress

onready var tween = $Tween

func start_progress(color_actual:Color)->void:
	tint_progress = color_actual
	tween.interpolate_property(self, 'value', value, 100, 10)
	tween.start()

func _on_Tween_tween_all_completed():
	value = 0
