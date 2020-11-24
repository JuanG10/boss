extends Node2D

func myShow():
	show()
	$Camera2D._set_current(true)

func myHide():
	hide()
	$Camera2D._set_current(false)
