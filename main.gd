extends Node

onready var enemy_template = preload("res://Enemies/BasicEnemy/BasicEnemy.tscn")

func _ready():
	var enemy:Area2D = enemy_template.instance()
	enemy.initialize($Player)
	enemy.set_position(Vector2(120,120)) 
	add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
