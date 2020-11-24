extends Node

var actual_level
var next_level 



const levels = {
	1:"res://Levels/Level 1.tscn",
	2:"res://Levels/Level 2.tscn",
	3:"res://Levels/Level 3.tscn",
	4:"res://Levels/Level 4.tscn",
	5:"res://Levels/Level 5.tscn",
	6:"res://Levels/Level 6.tscn"	
}

func set_actual_level(level):
	actual_level = level
	next_level = actual_level + 1	

func next_level()-> String:
	return levels[next_level]
		
func get_actual_level():
	return levels[actual_level]
	
			
	
