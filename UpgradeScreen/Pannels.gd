extends Panel

export (Resource) var background

onready var transition:TextureProgress = $TransitionAnimation
var new_style = StyleBoxTexture.new()
var ends_transition_animation = true
const TRANSITION_VELOCITY = 5

func _ready():
	new_style.texture = background
	set("custom_styles/panel", new_style)

func _physics_process(delta):
	if transition.get_value() == transition.max_value:
		ends_transition_animation = true
	else: ends_transition_animation = false

func _transition_progress():
	var temp_value
	if ends_transition_animation:
		temp_value = transition.get_value() - TRANSITION_VELOCITY
	else: 
		temp_value = transition.get_value() + TRANSITION_VELOCITY
	transition.set_value(temp_value)

func _on_button_up(fill_mode:int, next_pos:Vector2)->void:
	# fill_mode debe ser 0-8. Ver en documentacion de TextureProgress.
	transition.set_fill_mode(fill_mode)
	UpgradeWindow.change_panel_to(next_pos)
