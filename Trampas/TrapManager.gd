extends Node2D

const TRAPS = {
	RED = preload("res://Trampas/RedTrap.tscn"),
	BLUE = preload("res://Trampas/BlueTrap.tscn"),
	GREEN = preload("res://Trampas/GreenTrap.tscn")
}

const WIDTH:int = 300
const HEIGHT:int = 300

var open_simplex_noise:OpenSimplexNoise

var trap:Node2D
var trap_counter:int

onready var main:Node = get_tree().current_scene

func _ready():
	trap_counter = 0
	main = get_tree().current_scene # Creo que no hace nada...

	randomize()
	open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = randi()

	open_simplex_noise.octaves = 3
	open_simplex_noise.period = 10
	open_simplex_noise.lacunarity = 1.1
	open_simplex_noise.persistence = 0.7

	_generate()

func _generate():
	for x in WIDTH:
		for y in HEIGHT:
			_get_tile_index(open_simplex_noise.get_noise_2d(float(x),float(y)), x, y)

func _get_tile_index(noise:float, x:int, y:int)->void:
	if noise >= 0.67:
		_add_new_trap(Vector2(x,y), "trap" + str(trap_counter), TRAPS.BLUE)
		trap_counter += 1

func _add_new_trap(new_pos:Vector2, new_name:String, trap_type:PackedScene)->void:
	var new_trap = trap_type.instance()
	new_trap.position = new_pos
	new_trap.set_name(new_name)
	main.add_child(new_trap)

func change_trap_type(color:Color)->void:
	for i in trap_counter:
		var trap_name:String = "trap" + str(i)
		if main != null:
			if main.get_node(trap_name) == null:
				_add_new_trap(Vector2(randi() % 1024, randi() % 600), trap_name, _get_new_color_trap(color))
			var actual_trap = main.get_node(trap_name)
			var pos = actual_trap.position
			main.remove_child(actual_trap)
			match color:
				Color.red: _add_new_trap(pos, trap_name, TRAPS.RED)
				Color.green: _add_new_trap(pos, trap_name, TRAPS.GREEN)
				Color.blue: _add_new_trap(pos, trap_name, TRAPS.BLUE)

func _get_new_color_trap(color:Color)->PackedScene:
	match color:
		Color.red: return TRAPS.RED
		Color.green: return TRAPS.GREEN
		Color.blue: return TRAPS.BLUE
		_: return null
