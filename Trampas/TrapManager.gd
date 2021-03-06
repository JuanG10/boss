extends Node2D

const TRAPS = {
	RED = preload("res://Trampas/RedTrap.tscn"),
	BLUE = preload("res://Trampas/BlueTrap.tscn"),
	ORANGE = preload("res://Trampas/GreenTrap.tscn")
}

const COLORS = {
	red = Color(.702, .0823, .0706),
	orange = Color(.9, .56, .0),
	blue = Color(.0627, .1255, .702)
}

const WIDTH:int = 900
const HEIGHT:int = 600

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
	if trap_type == TRAPS.ORANGE: new_trap.modulate = Color.orangered
	add_child(new_trap)

func change_trap_type(color:Color)->void:
	for i in trap_counter:
		var trap_name:String = "trap" + str(i)
		if get_node(trap_name) == null: # Restaura las trampas usadas
			_add_new_trap(Vector2(randi() % 740 + 126, randi() % 460 + 81), trap_name, _get_new_color_trap(color))
		var actual_trap = get_node(trap_name)
		var pos = actual_trap.position
		remove_child(actual_trap)
		match color:
			COLORS.red: _add_new_trap(pos, trap_name, TRAPS.RED)
			COLORS.orange: _add_new_trap(pos, trap_name, TRAPS.ORANGE)
			COLORS.blue: _add_new_trap(pos, trap_name, TRAPS.BLUE)

func _get_new_color_trap(color:Color)->PackedScene:
	match color:
		COLORS.red: return TRAPS.RED
		COLORS.orange: return TRAPS.ORANGE
		COLORS.blue: return TRAPS.BLUE
		_: return null
