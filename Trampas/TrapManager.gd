extends Node2D

const TRAPS = {
	RED = preload("res://Trampas/RedTrap.tscn"),
	BLUE = preload("res://Trampas/BlueTrap.tscn"),
	GREEN = preload("res://Trampas/GreenTrap.tscn")
}

const WIDTH:int = 1024
const HEIGHT:int = 550

var open_simplex_noise:OpenSimplexNoise

var trap:Node2D
var trap_counter:int

func _ready():
	trap_counter = 0

	randomize()
	open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = randi()

	open_simplex_noise.octaves = 4
	open_simplex_noise.period = 2
	open_simplex_noise.lacunarity = 0.8
	open_simplex_noise.persistence = 0.9

	_generate()

func _generate():
	for x in WIDTH:
		for y in HEIGHT:
			_get_tile_index(open_simplex_noise.get_noise_2d(float(x),float(y)), x, y)

func _get_tile_index(noise:float, x:int, y:int)->void:
	if noise <= -0.65: # rango de noise = 1, -1
		_add_new_trap(Vector2(x,y), "trap" + str(trap_counter), TRAPS.BLUE)
		trap_counter += 1

func _add_new_trap(new_pos:Vector2, new_name:String, trap_type:PackedScene)->void:
	var new_trap = trap_type.instance()
	new_trap.position = new_pos
	new_trap.set_name(new_name)
	add_child(new_trap)

func change_trap_type(color:Color)->void:
	for i in trap_counter:
		var trap_name:String = "trap" + str(i)
		if get_node(trap_name) == null:
			_add_new_trap(Vector2(randi() % 1024, randi() % 600), trap_name, _get_new_color_trap(color))
		var actual_trap = get_node(trap_name)
		var pos = actual_trap.position
		remove_child(actual_trap)
		match color:
			Color.red: _add_new_trap(pos, trap_name, TRAPS.RED)
			Color.green: _add_new_trap(pos, trap_name, TRAPS.GREEN)
			Color.blue: _add_new_trap(pos, trap_name, TRAPS.BLUE)

func _get_new_color_trap(color:Color)->PackedScene:
	match color:
		Color(.0627, .1255, .702): return TRAPS.RED
		Color(.702, .3216, .1216): return TRAPS.GREEN
		Color(.702, .0823, .0706): return TRAPS.BLUE
		_: return null
