extends Node2D

const TRAPS = {
	RED = preload("res://Trampas/RedTrap.tscn"),
	BLUE = preload("res://Trampas/BlueTrap.tscn"),
	GREEN = preload("res://Trampas/GreenTrap.tscn")
}

const WIDTH:int = 1024
const HEIGHT:int = 600

var open_simplex_noise:OpenSimplexNoise

var trap:Node2D

func _ready():
	trap = TRAPS.BLUE.instance()
	trap.position = Vector2(520,200) # Temporalmente.
	get_tree().get_root().get_node("Main").add_child(trap)
#	randomize()
#	open_simplex_noise = OpenSimplexNoise.new()
#	open_simplex_noise.seed = randi()
#
#	open_simplex_noise.octaves = 3
#	open_simplex_noise.period = 10
#	open_simplex_noise.lacunarity = 1.1
#	open_simplex_noise.persistence = 0.7
#
#	_generate()
#
#func _generate():
#	for x in WIDTH:
#		for y in HEIGHT:
#			_get_tile_index(open_simplex_noise.get_noise_2d(float(x),float(y)))
#
#func _get_tile_index(noise:float):
#	if noise >= 0.5:
#		pass

func change_trap_type(color:Color)->void:
	match color:
		Color.red: print("red")
		Color.green: print("green")
		Color.blue: print("blue")
