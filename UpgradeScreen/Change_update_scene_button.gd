extends Panel

# Este código es temporal. Esta hardcodeado.

const BG_COLORS = {
	RED_BG = preload("res://Fondos/fondo-rojo.jpg"),
	GREEN_BG = preload("res://Fondos/fondo-verde.jpg"),
	PURPLE_BG = preload("res://Fondos/fondo-purpura.jpg"),
	BASE = preload("res://Fondos/fondo-tres-futbol.jpg")
}

# Formas de transición (Más en la documentación de Godot)
const LEFT_TO_RIGHT = 0
const RIGHT_TO_LEFT = 1
const TOP_TO_BOTTOM = 2
const CLOCKWISE_AND_COUNTER_CLOCKWISE = 8

onready var transition:TextureProgress = $TransitionAnimation
var new_style = StyleBoxTexture.new()
var ends_transition_animation = true

func _ready():
	new_style.texture = BG_COLORS.RED_BG
	set("custom_styles/panel", new_style)

func _physics_process(delta):
	if transition.get_value() < transition.max_value and not ends_transition_animation:
		transition.set_value(transition.get_value() + 4)
	else:
		ends_transition_animation = true
		transition.set_value(transition.get_value() - 4)

func _on_button_up(id:int)->void:
	transition.set_fill_mode(LEFT_TO_RIGHT)
	if id == 1:
		transition.set_fill_mode(CLOCKWISE_AND_COUNTER_CLOCKWISE)
		ends_transition_animation = false
		new_style.texture = BG_COLORS.BASE
	elif new_style.texture == BG_COLORS.RED_BG:
		ends_transition_animation = false
		new_style.texture = BG_COLORS.GREEN_BG
	elif new_style.texture == BG_COLORS.GREEN_BG:
		ends_transition_animation = false
		new_style.texture = BG_COLORS.PURPLE_BG
	else: 
		ends_transition_animation = false
		new_style.texture = BG_COLORS.RED_BG
