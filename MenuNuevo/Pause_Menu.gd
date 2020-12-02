extends Control



func myShow():
	show()
	$ParallaxBackground/ParallaxLayer.show()
	#$Camera2D._set_current(true)

func myHide():
	hide()
	$ParallaxBackground/ParallaxLayer.hide()
	#$Camera2D._set_current(false)


func _ready():
	#Background.hide()
	Background.show()
	pass
