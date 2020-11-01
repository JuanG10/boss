extends Node2D

const BASE = preload("res://UpgradeScreen/BasePanel.tscn")
const RED = preload("res://UpgradeScreen/RedPanel.tscn")
const GREEN = preload("res://UpgradeScreen/GreenPanel.tscn")
# Quería hacer esto con exports pero siempre daba null.
onready var color_level = [RED,GREEN]
onready var base_level = [BASE]
onready var panel_matrix = [color_level,base_level] # y = [0,1]
var actualPanel:Panel
var actual_pos = Vector2(0,1) # Cuidado, 'y' es el segundo argumento

func _ready():
	actualPanel = panel_matrix[actual_pos.y][actual_pos.x].instance()
	get_tree().get_root().get_node("Main").add_child(actualPanel)
	print(get_tree().get_root().get_node("Main").get_children())

func change_panel_to(next_panel:Vector2)->void:
	actual_pos += next_panel
	if _array_problems(): actual_pos -= next_panel
	else:
		actualPanel.queue_free()
		actualPanel = panel_matrix[actual_pos.y][actual_pos.x].instance()
		get_tree().get_root().get_node("Main").add_child(actualPanel)
		print(actual_pos)
		print(actualPanel)

func _array_problems()->bool:
	return actual_pos.y < 0 || actual_pos.x < 0 || actual_pos.y > panel_matrix.size() - 1 || actual_pos.x > panel_matrix[actual_pos.y].size() - 1
