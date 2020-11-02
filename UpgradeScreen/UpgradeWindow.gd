extends Node2D

const PANELS = {
	BASE = preload("res://UpgradeScreen/BasePanel.tscn"),
	RED = preload("res://UpgradeScreen/RedPanel.tscn"),
	GREEN = preload("res://UpgradeScreen/GreenPanel.tscn")
}

const LEVELS = {
	color_level = [PANELS.RED,PANELS.GREEN],
	base_level = [PANELS.BASE]
}

onready var panel_matrix = [LEVELS.color_level,LEVELS.base_level] # y
var actualPanel:Panel
var actual_pos = Vector2(0,1) # Cuidado, 'y' es el segundo argumento

onready var transition:TextureProgress = $TransitionAnimation
signal start_animation

func _ready():
	actualPanel = panel_matrix[actual_pos.y][actual_pos.x].instance()
	actualPanel.show_behind_parent = true
	_add_actual_panel()

func change_panel_to(fill_mode:int, next_panel:Vector2)->void:
	actual_pos += next_panel
	if _array_problems(): actual_pos -= next_panel
	else:
		transition.set_fill_mode(fill_mode)
		emit_signal("start_animation")

func _array_problems()->bool:
	return actual_pos.y < 0 || actual_pos.x < 0 || actual_pos.y > panel_matrix.size() - 1 || actual_pos.x > panel_matrix[actual_pos.y].size() - 1

func _on_end_animation():
	actualPanel.queue_free()
	actualPanel = panel_matrix[actual_pos.y][actual_pos.x].instance()
	actualPanel.show_behind_parent = true
	_add_actual_panel()
	emit_signal("start_animation")
	print(actualPanel)

func _add_actual_panel()->void:
	get_node("/root/UpgradeWindow").add_child(actualPanel)
