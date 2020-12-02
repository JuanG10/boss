extends Panel

export (Resource) var background

var nivel

onready var upgradeMainWindow:Node2D = get_parent()
var new_style = StyleBoxTexture.new()

func set_nivel(level):
	nivel = level

func _ready():
	new_style.texture = background
	set("custom_styles/panel", new_style)
	set_color_next_level()

func _on_button_up(fill_mode:int, next_pos:Vector2)->void:
	# fill_mode debe ser 0-8. Ver en documentacion de TextureProgress.
	upgradeMainWindow.change_panel_to(fill_mode, next_pos)

func _on_Play_again_button_up():
	Background._ready()
	GlobalVariables.points = 0
	upgradeMainWindow.get_tree().change_scene(ManagerLevels.get_actual_level())

func update_coins():
	$Coins.on_update()

func _on_Next_Level_pressed():
	if(ManagerLevels.level_crossing):
		Background._ready()
		GlobalVariables.points = 0
		upgradeMainWindow.get_tree().change_scene(ManagerLevels.next_level())

func set_color_next_level():
	if(!ManagerLevels.level_crossing):
		$Next_Level.add_color_override("font_color_hover",Color(.702, .0823, .0706))
	else:
		$Next_Level.add_color_override("font_color_hover",Color(0.184314,0.890196,0.082353,1))	

