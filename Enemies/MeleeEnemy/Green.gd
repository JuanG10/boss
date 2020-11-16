extends "res://state_machine/state.gd"

func update(_delta):
	emit_signal("finished", "chasing")
