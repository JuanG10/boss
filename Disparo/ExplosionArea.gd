extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	if emitting && $Area2D/CollisionShape2D.disabled:
		$Area2D/CollisionShape2D.disabled = false
	
	
		
func activate_senial():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	pass
	#print(area.get_name())
