extends "res://state_machine/state_machine.gd"

onready var chasing = $Chasing
onready var special_red = $Red
onready var special_blue = $Blue

func _ready():
	states_map = {
		"chasing"        : chasing,
		"special_red"    : special_red,
		"special_blue"   : special_blue,
	}

func init(player, enemy):
	for state in states_map.values():
		state.initialize(player, enemy)

func _change_state(state_name):
	if not _active:
		return
	._change_state(state_name)
