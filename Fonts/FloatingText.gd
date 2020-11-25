extends Position2D

onready var label = $Label
onready var twenn = $Tween
onready var player = get_parent()

#const Y_RANGE = 30
#var side_movement:int
#var velocity:Vector2

var amount:int
var color:Color

#var direction:bool

func _ready():
#	if twenn.is_active():
#		const_amount += amount
#	else:
#		const_amount = amount
	label.set_text(str(amount))
	label.get("custom_fonts/font").outline_color = color
#	match type:
#		"Heal":
#			label.set("custom_colors/font_color", Color("2eff27"))
#		"Damage":
#			label.set("custom_colors/font_color", Color("ffa1a1"))
	
#	randomize()
#	direction = bool(randi() % 2)
#	side_movement = randi() % 100
	
	
	twenn.interpolate_property(self, 'scale', scale, Vector2(1.1,1.1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	twenn.interpolate_property(self, 'scale', Vector2(1.1,1.1), Vector2(0.1,0.1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.25)
	twenn.start()

#func _process(delta):
#	if direction:
#		position -= velocity * delta
#	else: position += velocity * delta

func _on_Tween_tween_all_completed():
	queue_free() # Ni idea como hacer que se reinicie.
