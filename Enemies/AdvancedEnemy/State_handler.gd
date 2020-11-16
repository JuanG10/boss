extends "res://state_machine/state_machine.gd"

onready var chasing = $Chasing
onready var minimun_range = $Minimun_range
onready var special_red = $Color_Special/Red
onready var special_blue = $Color_Special/Blue
onready var special_green = $Color_Special/Green

func _ready():
	states_map = {
		"chasing"       : chasing,
		"minimun_range" : minimun_range,
		"special_red"   : special_red,
		"special_green" : special_green,
		"special_blue"  : special_blue,
	}

func init(player, enemy):
	for state in states_map.values():
		state.initialize(player, enemy)

func _change_state(state_name):
	if not _active:
		return
	._change_state(state_name)

