extends Label




func _ready():
	set_text("Habilidades: ")
	set_names_habilidades()
		
	
func on_update():
	set_text("Habilidades: " + str(GlobalVariables.money))


func set_names_habilidades():
	for name_habilidad in GlobalVariables.habilidadres:
		set_text(text + " " + str(name_habilidad))
