extends Node2D

export (Array, Array, PackedScene) var pannel_matrix

var actualPannel:Panel
var actual_pos = Vector2(0,0)

func _ready():
	if pannel_matrix != []:
		actualPannel = pannel_matrix[actual_pos.y][actual_pos.x].instance()
		add_child(actualPannel)

func _process(delta):
	print(pannel_matrix)
	print(actualPannel)

func change_pannel_to(next_panel:Vector2)->void:
	actual_pos += next_panel
	if actualPannel[actual_pos.y][actual_pos.x] == null:
		actual_pos -= next_panel
		return
	if pannel_matrix != [] && actualPannel != null:
		actualPannel = pannel_matrix[actual_pos.y][actual_pos.x].instance()
		get_child(0).replace_by(actualPannel)
